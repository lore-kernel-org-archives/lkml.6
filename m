Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeEULrF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:47:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:36549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbeEULrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:47:01 -0400
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [BUG] get_maintainer: chmod handling
Date: Mon, 21 May 2018 13:46:48 +0200
Message-Id: <20180521114648.3972-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.17.0
X-Provags-ID: V03:K1:D5WRNAB8J8zhmTNr3ASq4JROS522rwWIt461VRgs0PW3wSzfzNB
 piTy/nNl/i6Xgz7xPpiemJ11NrTFPoiTYUhAZp+9uVWnmrg5F7id3gBW54vLmzZK7H2DfVe
 zcS3d81oebNNbWJMzsgA7W7lnXVNe1SPrZbpAjYksyNUK/OiE188HLniCDmP/c0qG+t2fUi
 /+d5MyVpqj2k7oXkufa7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sFY4b9Uqx6U=:VKz5cAKuTvFZoQogGgKbJ9
 G6VVbUNfW16Vo5sAqH2rSEi3xtamkelwfbrutKiItSGM56HRtaASP9YpB+LRMAI3K5slEqswJ
 nx+zOvQchgta59nLhDWOuCmjOnnu4eUhsrgaAbEJOuezqIaMK6jahhkwz8yWPpvDx4P60I6wp
 94HaVCTnflDBp1pHvBNlQgsmPjpYRLIv0+tN/uBp7O3YaCRlpGV0866IFGhboOGmgXVkgSoRq
 0O91ApKQeHcM3Z0L8d8ZOPoXQl0CzjTKiebuyngY1uZPN3B6TTOktI/fohQDPeP5rD6hE2pWv
 0rBh+KpT/r4yfTZborPIr0H6IfgMCAUIk7kB3q0NNKGHy07Fill0/n6U8GL8t+6gwNwWdfp4e
 pKQ+opI84v7OR89jzyWmZ/7CnVp8YQtgYghXbVFk69ajTCnK5UFxVcCYvib7fKAUgpC4VU0wj
 2jQD7qEGLBkAxBkkSjRqtha8wH/KDeDLVdFXs0fDNpLzojx7u+qP7ovhoUlQP9j+OHDys3A0K
 3EzDVAgANW7x0YPxE6n32+JlRgUHbnKtg6yUrFbtk5nDB2/9CQtMXK6bkESvA9N42lCu7bXW/
 icBp3kyBsradsEvfwqcFLdZz/qbpUM3YJZexCkOW1pp+G+/vXe7OXgyV+X1yjjtxT/rXeBFwA
 qyGXfp7V7UVKn+VC0W5O0lGKJZ2VyEr696U8EwV4Y16zBqspgjAZJBN2IvhEcsv+YOnYUFzrU
 sdjZF0H5yezDpituDK0CtZpIk3nw/4cwJWi0fvrNZob0tEM0AR49KVq4n9M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a false positive:
file '0001-foo.patch' doesn't appear to be a patch.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 samples/mic/noned/none | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 samples/mic/noned/none

diff --git a/samples/mic/noned/none b/samples/mic/noned/none
old mode 100755
new mode 100644
-- 
2.17.0
