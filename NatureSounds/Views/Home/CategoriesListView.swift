//
//  CategoryListView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import SwiftUI

struct CategoryListView: View {
    
    let categories: [Category]
    let columns:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(categories,id:\.id) { Category  in
                    NavigationLink(destination: CategorySongsView(Category:Category)) {
                        CategoryCard(Category:Category.Category)
                    }
                }
            }
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(categories: [])
    }
}
