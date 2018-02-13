Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966050AbeBMWh1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:37:27 -0500
Received: from mout.gmx.net ([212.227.15.18]:34461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965942AbeBMWhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:37:25 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-doc@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] admin-guide: Fix list formatting in tained-kernels.html
Date: Tue, 13 Feb 2018 23:36:51 +0100
Message-Id: <20180213223653.6437-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:FxrAYuww9MA7CDGZhLGzII/0AG8S1vXcrOlvOdLys4demTPPGCe
 unchiam8Rtt1/O8UqiYm3ZYNO7JVWUeGF8r/+3N85YH9Pcp5vNvTB0wf4nlzCkQaqR+yToY
 z3qXvfyoI4dPFKgFw8ng1cr2K+p8+j8k/j8w6yl5LswhfWJl58vcYrBzBTpvJ56jEFI5/4n
 vgHp2mNM7lS7sT3GYvEPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ilQDhF7YN5M=:Tn2XjE5CGUqIrfCVUzwujv
 Vf5jHBugdi0oO6P7zjh9B3DMtYKvQUMn4xvbdb8ui4Jw/2t+dcn5EA9gvvMtfrIKXzrotZZvq
 sS/w4EM8ZPlcRlIF7F6ADnsHonIKsBo/AhXqeg4zso8KXZxZAnkPmoDHZGsrVg7T7WJ2JVH20
 cvLnAGW/5/PhauC9G0WQvsDjdT46ohN+FT6vksVAhojnOgLaLDRIu3zjTVg0d/KxZE9/RMwbV
 5XqPHqCydOXpSc7GZrwp3FAuQw2tzQmKVxv/UEPAQRY6/67yt/hc/oLRUvkNEy0uaQEUIH64L
 kTYQ1xiJXBPka/HQObo5l8ZYiPUAd8VixelwDHCvfZrMRbwf8Kw8IK1BQJ1KYSjDkjtmAW2lu
 57xfRBMmIZ6qE1eFB1iWDxF324G64meLjH7jjUvk+7J+mckG2YWC+AvEifXzdkkv8PeyVRo+I
 4nQ+zKcr4gnkvjrSGEPKAcHK4fvtpWFBSIK59kQhwj9hoHdTu88a8W8As+OWtYmhY26O/9rw/
 3mHGqU+nOAG5P8awYYVh33s6pyQrs3l419zVTA+uHasc9u1Os7T8/b49Fgom+zxrEXmeUWOv/
 MkygLB+C5/jNZUBGqEyozws1BaCgU1gFJ/vkfHp1nt3OHn7959IxiMUNuSJHgXOZStrPi3i95
 mYdOC+cMQe113M5aQklyvFTPtn3zq9RWl9wDRDXcSB2sqre6weEskBNlI9kPpaZphqeSWKlyY
 b2GFIjjjNXHa2bYbosvu+9RA08TG5xKL7sQh7+MFk62/kfEhyrxMKxBX/B0aGLfPLdo4MXAE0
 bVvX7gvddcdmenwXKknJP2CeseFNCVQs+ufhaHvdGe/oodaGTg1ro1dtlbFQ0AkssTP6FVB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, the points 1-9 in the list are rendered as an HTML
blockquote containing a list, causing them to be indented further than
the rest of the list.

While at it, also fix the quotation marks around G and P.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/admin-guide/tainted-kernels.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 1df03b5cb02f..28a869c509a0 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -6,34 +6,34 @@ counter. This indicates that the kernel has been tainted by some
 mechanism.  The string is followed by a series of position-sensitive
 characters, each representing a particular tainted value.
 
-  1) 'G' if all modules loaded have a GPL or compatible license, 'P' if
+ 1)  ``G`` if all modules loaded have a GPL or compatible license, ``P`` if
      any proprietary module has been loaded.  Modules without a
      MODULE_LICENSE or with a MODULE_LICENSE that is not recognised by
      insmod as GPL compatible are assumed to be proprietary.
 
-  2) ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
+ 2)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
      modules were loaded normally.
 
-  3) ``S`` if the oops occurred on an SMP kernel running on hardware that
+ 3)  ``S`` if the oops occurred on an SMP kernel running on hardware that
      hasn't been certified as safe to run multiprocessor.
      Currently this occurs only on various Athlons that are not
      SMP capable.
 
-  4) ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
+ 4)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
      modules were unloaded normally.
 
-  5) ``M`` if any processor has reported a Machine Check Exception,
+ 5)  ``M`` if any processor has reported a Machine Check Exception,
      ``' '`` if no Machine Check Exceptions have occurred.
 
-  6) ``B`` if a page-release function has found a bad page reference or
+ 6)  ``B`` if a page-release function has found a bad page reference or
      some unexpected page flags.
 
-  7) ``U`` if a user or user application specifically requested that the
+ 7)  ``U`` if a user or user application specifically requested that the
      Tainted flag be set, ``' '`` otherwise.
 
-  8) ``D`` if the kernel has died recently, i.e. there was an OOPS or BUG.
+ 8)  ``D`` if the kernel has died recently, i.e. there was an OOPS or BUG.
 
-  9) ``A`` if the ACPI table has been overridden.
+ 9)  ``A`` if the ACPI table has been overridden.
 
  10) ``W`` if a warning has previously been issued by the kernel.
      (Though some warnings may set more specific taint flags.)
-- 
2.15.1
