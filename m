Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeE3LZE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:25:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33299 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753033AbeE3LYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:24:44 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "=?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?="
        <ernesto.mnd.fernandez@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.490247354@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 040/153] ext4: correct documentation for grpid mount
 option
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ernesto A. Fernández
 <ernesto.mnd.fernandez@gmail.com>

commit 9f0372488cc9243018a812e8cfbf27de650b187b upstream.

The grpid option is currently described as being the same as nogrpid.

Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/filesystems/ext4.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/filesystems/ext4.txt
+++ b/Documentation/filesystems/ext4.txt
@@ -238,7 +238,7 @@ data_err=ignore(*)	Just print an error m
 data_err=abort		Abort the journal if an error occurs in a file
 			data buffer in ordered mode.
 
-grpid			Give objects the same group ID as their creator.
+grpid			New objects have the group ID of their parent.
 bsdgroups
 
 nogrpid		(*)	New objects have the group ID of their creator.
