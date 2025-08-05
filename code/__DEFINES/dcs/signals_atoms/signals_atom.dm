///from base of atom/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
#define COMSIG_ATOM_HITBY "atom_hitby"
///from base of atom/attackby(): (/obj/item, /mob/living, params)
#define COMSIG_ATOM_ATTACKBY "atom_attackby"
///from base of atom/examine(): (/mob, list/examine_text)
#define COMSIG_ATOM_EXAMINE "atom_examine"
///from base of atom/examine_tags(): (/mob, list/examine_tags)
#define COMSIG_ATOM_EXAMINE_TAGS "atom_examine_tags"
///from base of atom/examine_more(): (/mob, examine_list)
#define COMSIG_ATOM_EXAMINE_MORE "atom_examine_more"

/// Sent on COMPILE_OVERLAYS()
/// * Make extra, extra sure you **do not** call managed overlay procs like add_overlay() or cut_overlay()
///   when handling this signal; doing so WILL cause an infinite loop!
#define COMSIG_ATOM_COMPILED_OVERLAYS "atom-compile_overlays"
