//
//  ProjectView.swift
//  UltimatePortfolio
//
//  Created by 山崎宏哉 on 2022/01/08.
//

import SwiftUI

struct ProjectView: View {
    // The type is corresponding to SceneStorage "selectedView"(String?).
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false

    var projectsList: some View {
        List {
            ForEach(viewModel.projects) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(project.projectItems(using: viewModel.sortOrder)) { item in
                        ItemRowView(project: project, item: item)
                    }
                    .onDelete { offsets in
                        viewModel.delete(offsets, form: project)
                    }

                    if !viewModel.showClosedProjects {
                        Button {
                            withAnimation {
                                viewModel.addItem(to: project)
                            }
                        } label: {
                            Label("Add New Item", systemImage: "plus")
                        }
                    }
                } //: Section
            } //: ForEach
        } //: List
        .listStyle(InsetGroupedListStyle())
    }

    var addProjectToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if !viewModel.showClosedProjects {
                Button {
                    withAnimation {
                        viewModel.addProject()
                    }
                } label: {
                    // In iOS 14.3 VoiceOver has a glich that reads the label
                    // "Add Project" as "Add" no matter what accesibility label
                    // we give this toolbar button when using a Label.
                    // As a result, when VoiceOVer is running, we use a text view for
                    // the button instead, forcing a correct reading without losing
                    // the original layout.
                    if UIAccessibility.isVoiceOverRunning {
                        Text("Add Project")
                    } else {
                        Label("Add Project", systemImage: "plus")
                    }
                }
            }
        }
    }

    var sortOrderToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showingSortOrder.toggle()
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.projects.isEmpty {
                    Text("There's nothing here right now")
                        .foregroundColor(.secondary)
                } else {
                    projectsList
                } //: Else
            } //: Group
            .navigationTitle(viewModel.showClosedProjects ? "Closed Projects" : "Open Projects")
            .toolbar {
                addProjectToolbarItem
                sortOrderToolbarItem
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Optimized")) { viewModel.sortOrder = .optimized },
                    .default(Text("Creation Date")) { viewModel.sortOrder = .creationDate },
                    .default(Text("Title")) { viewModel.sortOrder = .title }
                ])
            }

            SelectSomethingView()
        } //: NavigationView
    } //: Body

    init(dataController: DataController, showClosedProjects: Bool) {
        let viewModel = ViewModel(dataController: dataController, showClosedProjects: showClosedProjects)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        ProjectView(dataController: dataController, showClosedProjects: false)
    }
}
