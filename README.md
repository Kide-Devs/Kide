# Kide
## v1.0.3

A new Flutter project.

## Nomenclature

- ### Event
    - The Entire Event/Fest e.g. KIITFEST
    - #### Schema
        - String id, String name, List<"EventCategory"> eventCategories, String startDate, String endDate
- ### EventCategory
    - Category in the Event e.g. Luminare, ElectroNerd, Builder.io, etc
    - #### Schema
        - String id, String name, List<"SubEvent"> subEvents
- ### SubEvent
    - Event inside of an Event Category
    - #### Schema
        - String id, String name, String date, String time, String description, String location, bool isBookmarked, String link_details, String link_register



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
