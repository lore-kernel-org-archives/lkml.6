Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbeFASql (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753373AbeFASqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:46:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: devel@driverdev.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/5] ncpfs: remove uapi .h files
Date: Fri,  1 Jun 2018 20:45:46 +0200
Message-Id: <20180601184547.20213-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601184547.20213-1-gregkh@linuxfoundation.org>
References: <20180601184547.20213-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ncpfs is removed from the tree, there is no need to keep the
uapi header files around as no one uses them, and it is not a feature
that the kernel supports anymore.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/ncp.h       | 202 ---------------------------------
 include/uapi/linux/ncp_fs.h    | 147 ------------------------
 include/uapi/linux/ncp_mount.h |  72 ------------
 include/uapi/linux/ncp_no.h    |  20 ----
 4 files changed, 441 deletions(-)
 delete mode 100644 include/uapi/linux/ncp.h
 delete mode 100644 include/uapi/linux/ncp_fs.h
 delete mode 100644 include/uapi/linux/ncp_mount.h
 delete mode 100644 include/uapi/linux/ncp_no.h

diff --git a/include/uapi/linux/ncp.h b/include/uapi/linux/ncp.h
deleted file mode 100644
index ca6f3d42c88f..000000000000
diff --git a/include/uapi/linux/ncp_fs.h b/include/uapi/linux/ncp_fs.h
deleted file mode 100644
index e76a44229d2f..000000000000
diff --git a/include/uapi/linux/ncp_mount.h b/include/uapi/linux/ncp_mount.h
deleted file mode 100644
index 9bdbcd68c329..000000000000
diff --git a/include/uapi/linux/ncp_no.h b/include/uapi/linux/ncp_no.h
deleted file mode 100644
index 654d7c7f5d92..000000000000
-- 
2.17.1
