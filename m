Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1030C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC92217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfBIPFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:05:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:47603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfBIPFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 10:05:43 -0500
Received: from [192.168.65.3] ([92.249.131.222]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lx4dh-1hCKU218vJ-016gvJ; Sat, 09
 Feb 2019 16:05:35 +0100
Date:   Sat, 9 Feb 2019 16:05:33 +0100 (CET)
From:   Tibor Billes <tbilles@gmx.com>
X-X-Sender: tbilles@serpens
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org
Subject: [PATCH] cgroup: add documentation for pids.events file
Message-ID: <alpine.DEB.2.20.1902091539220.29523@serpens>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ncWfTqeBAE78cpiwACoqwjrfIY+SM2XNhMGeOBrOaTneNy2vQ1m
 +2D2lBCfcsUHdn1zOqZNeXVLGbKYBWUeM92gRIrHIrVRuY5XI+b9q0Mwh2N59K6yem3uWNO
 6xjHhbIaJNoffxNDRqq/CsjyHG/MGx+pzpNpkaIsDeE/zsPcwl1HM4yQInpnlMWiG4Q0d22
 qYhtfT59/USeGOCIbci8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:anvuXEKq8nw=:NZBSYOztDbPn7GJAOHiMeX
 S6l9T0Gj3ZYYpzvAq0OmDMhiFmDoyg8hVHmCRZ0643RT35a0PWU5R0bHxDdorgXtKkkiSBow5
 HIKZS9cC6+qjprQq+0fDivne9je1+GK13fsaqTBbNvJAbdEqVc3kQq14o+4fslJ1+5Qc1pSZY
 l1z2FnTRc1s8+YvWKJ26W/UOWZAtJc66zj+8GFbM2FziYa/Tj2nW3vaJKV+fZLEcZ0uSUNT7Y
 rRYjiCyYrKTXpgp3YAL6aZ4/p0XUK198E0Wyh6tpABu5X1Dt7d2ZPGjTvU6fcqAJ/J3hQLJ21
 SsmzXw2b7itZp7TWDOXpeKnluQywlE9T+rUQ9hdfpRbJOHMJWpswvzKuUYGkWCAA4jb5XuDeV
 L0GMBlWpSwFnhplQXy2s9GdvyruAD/IfKEfvZOvA8R9j5/eCIA+FOknvJb6lWniTV4EtcZGrD
 rnLpBVr2je9CvCfW5mkqzGK0ZC9gTrbBMzvirxZ8lORsK4PFcL0eOVbSUm05iYFokLihQOID9
 jc9kTSHuCGamutRPHgBWfEIoIyB79+6Afy3zKiMO3llCz6BUyGsNdNOFQoZA4vZ+mwT11dPCR
 AUCpx0cUYj/Si0t/3W+O0SgGYmLjj6uldQvIkwwYET9b90hawmX0HdalQt5KJshQ7XPJQX5iv
 pU5GrA8JYbxdyhD90DbCk2UE3r2i275Cft0P12thAmFgw/iZ4e5AhoU48mgHmLH9PcTZNF6Vm
 eJvkr25iCqTuuzMUrcPcV4Ljj60m983cR0yMMahFHybVRGT2J3gqQivJXd2Y6xUIaNZkI1KMC
 XXJMpBkECGBHy/n7OyBh44/CN6FFUPF6jHqGLl441ksXUZyuv68KAZjUcJ/U4r5s9MGJSxwpO
 HzJfRNoXt3MRZfOhcnp8VOAiVApVLi2F6PY5xU0RumjM0U7sTgUWm7LlEkAlqtxtXtzhQ/DC8
 CGgdthapJyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgroup: add documentation for pids.events file

Document the event counters file for pid cgroups.

Signed-off-by: Tibor Billes <tbilles@gmx.com>
---
 Documentation/cgroup-v1/pids.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/cgroup-v1/pids.txt b/Documentation/cgroup-v1/pids.txt
index 1a078b5..e105d70 100644
--- a/Documentation/cgroup-v1/pids.txt
+++ b/Documentation/cgroup-v1/pids.txt
@@ -33,6 +33,9 @@ limit in the hierarchy is followed).
 pids.current tracks all child cgroup hierarchies, so parent/pids.current is a
 superset of parent/child/pids.current.
 
+The pids.events file contains event counters:
+  - max: Number of times fork failed because limit was hit.
+
 Example
 -------
 
