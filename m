Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA80CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DC62084A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeL3Quv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:50:51 -0500
Received: from wes1-so1-b.wedos.net ([46.28.106.43]:60940 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725954AbeL3Quv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:50:51 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 43SRK35Tgsz4gK;
        Sun, 30 Dec 2018 17:50:47 +0100 (CET)
Date:   Sun, 30 Dec 2018 17:50:44 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-doc@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] doc: cgroup: highlight all paths using the :file: inline
 markup
Message-ID: <20181230165044.GA3097@personal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Improve readability using the :file: markup.

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 80c88a0869e4..6e90a4fce347 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -9,7 +9,7 @@ This is the authoritative documentation on the design, inte=
rface and
 conventions of cgroup v2.  It describes all userland-visible aspects
 of cgroup including core and specific controller behaviors.  All
 future changes must be reflected in this document.  Documentation for
-v1 is available under Documentation/cgroup-v1/.
+v1 is available under :file:`Documentation/cgroup-v1/`.
=20
 .. CONTENTS
=20
@@ -216,7 +216,7 @@ considered empty and can be removed::
=20
   # rmdir $CGROUP_NAME
=20
-"/proc/$PID/cgroup" lists a process's cgroup membership.  If legacy
+:file:`/proc/{$PID}/cgroup` lists a process's cgroup membership.  If legacy
 cgroup is in use in the system, this file may contain multiple lines,
 one for each hierarchy.  The entry for cgroup v2 is always in the
 format "0::$PATH"::
@@ -545,7 +545,7 @@ all processes under C0 and C1 belong to U0:
   }
=20
 Let's also say U0 wants to write the PID of a process which is
-currently in C10 into "C00/cgroup.procs".  U0 has write access to the
+currently in C10 into :file:`C00/cgroup.procs`.  U0 has write access to the
 file; however, the common ancestor of the source cgroup C10 and the
 destination cgroup C00 is above the points of delegation and U0 would
 not have write access to its "cgroup.procs" files and thus the write
@@ -1852,7 +1852,7 @@ If the program returns 0, the attempt fails with -EPE=
RM, otherwise
 it succeeds.
=20
 An example of BPF_CGROUP_DEVICE program may be found in the kernel
-source tree in the tools/testing/selftests/bpf/dev_cgroup.c file.
+source tree in the :file:`tools/testing/selftests/bpf/dev_cgroup.c` file.
=20
=20
 RDMA
@@ -1923,7 +1923,7 @@ root cgroup. This child cgroup weight is dependent on=
 its thread nice
 level.
=20
 For details of this mapping see sched_prio_to_weight array in
-kernel/sched/core.c file (values from this array should be scaled
+:file:`kernel/sched/core.c` file (values from this array should be scaled
 appropriately so the neutral - nice 0 - value is 100 instead of 1024).
=20
=20
@@ -1943,17 +1943,17 @@ Basics
 ------
=20
 cgroup namespace provides a mechanism to virtualize the view of the
-"/proc/$PID/cgroup" file and cgroup mounts.  The CLONE_NEWCGROUP clone
+:file:`/proc/{$PID}/cgroup` file and cgroup mounts.  The CLONE_NEWCGROUP c=
lone
 flag can be used with clone(2) and unshare(2) to create a new cgroup
 namespace.  The process running inside the cgroup namespace will have
-its "/proc/$PID/cgroup" output restricted to cgroupns root.  The
+its :file:`/proc/{$PID}/cgroup` output restricted to cgroupns root.  The
 cgroupns root is the cgroup of the process at the time of creation of
 the cgroup namespace.
=20
-Without cgroup namespace, the "/proc/$PID/cgroup" file shows the
+Without cgroup namespace, the :file:`/proc/{$PID}/cgroup` file shows the
 complete path of the cgroup of a process.  In a container setup where
 a set of cgroups and namespaces are intended to isolate processes the
-"/proc/$PID/cgroup" file may leak potential system level information
+:file:`/proc/{$PID}/cgroup` file may leak potential system level informati=
on
 to the isolated processes.  For Example::
=20
   # cat /proc/self/cgroup
@@ -2007,10 +2007,10 @@ process later moves to a different cgroup::
   # cat /proc/self/cgroup
   0::/sub_cgrp_1
=20
-Each process gets its namespace-specific view of "/proc/$PID/cgroup"
+Each process gets its namespace-specific view of :file:`/proc/{$PID}/cgrou=
p`.
=20
 Processes running inside the cgroup namespace will be able to see
-cgroup paths (in /proc/self/cgroup) only inside their root cgroup.
+cgroup paths (in :file:`/proc/self/cgroup`) only inside their root cgroup.
 From within an unshared cgroupns::
=20
   # sleep 100000 &
@@ -2078,7 +2078,7 @@ This will mount the unified cgroup hierarchy with cgr=
oupns root as the
 filesystem root.  The process needs CAP_SYS_ADMIN against its user and
 mount namespaces.
=20
-The virtualization of /proc/self/cgroup file combined with restricting
+The virtualization of :file:`/proc/self/cgroup` file combined with restric=
ting
 the view of cgroup hierarchy by namespace-private cgroupfs mount
 provides a properly isolated cgroup view inside the container.
=20
@@ -2137,7 +2137,7 @@ Deprecated v1 Core Features
=20
 - "cgroup.clone_children" is removed.
=20
-- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" file
+- :file:`/proc/cgroups` is meaningless for v2.  Use :file:`cgroup.controll=
ers` file
   at the root instead.
=20
=20
@@ -2220,7 +2220,7 @@ to lay programs.
=20
 First of all, cgroup has a fundamentally inadequate interface to be
 exposed this way.  For a process to access its own knobs, it has to
-extract the path on the target hierarchy from /proc/self/cgroup,
+extract the path on the target hierarchy from :file:`/proc/self/cgroup`,
 construct the path by appending the name of the knob to the path, open
 and then read and/or write to it.  This is not only extremely clunky
 and unusual but also inherently racy.  There is no conventional way to
--=20
2.17.2

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwo92MACgkQgjuumfi+
HjxbFw//fZjxQvazM/SD7IQhvGj2b7cFvqFp8T1prjPe86ZsCaGDPneHevkwSOh/
WrKGnVV/qU8xIu4mUUVCu4hWYH3yzS/W2W006M+O5B7r8YUiDyPOzgkl4eXtieWR
aww3KxCgS1ZRtyqhMElIfyAk9QaO8zYQs10pQW228Hx4eKjobRtceLCxoROeBL7z
fnQiH60ikYM94qwUEQCJwJTX2L58nn5IetJdZllKYR+lnq/oaErVDmfGzYuOtx3j
y8ICT1dG3URhgDdbOm2sumo2prfAI/URslqgTLZDbru7ocMvBuEMz7n6ZX1Ia898
c/P6s/EyWcPdm8zSJyu+XpB3nm1WQGJl7KWQAHuRJVxM3BSLS+8VsPQjdd7KqAb+
yFDNog/+rvye2Sx88fczOoi9TGTm2XEycABBGhlsw5omSJ8mqEIoXfJY+v2JVw77
uQsqKplH00vf+tlzhzSG5pl075jcDeVHx48/sdEHSVm6/9C1lWTbader8swr23Gg
P+cVg5zg+wdH38BGgl5fXOB1aNsqalLSEeg3al1RLUoSYKew8jS8S+xH9BWTR8ib
LLLtbH3fun9Epj63wxiN1Dk1zwQIP4qYLXd/g+j09LYLzLeEK0Z6ybrPMQDCRzex
xdjS/NoKHePPsp/4LmdEB8G4ZSc/TmiVf4aiVkmC/dZZ0ageXhY=
=HuiF
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
