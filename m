Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeBWVOP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:14:15 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:8757 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeBWVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:14:14 -0500
From: Toshi Kani <toshi.kani@hpe.com>
To: dan.j.williams@intel.com
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] update label size handlings per UEFI 2.7
Date: Fri, 23 Feb 2018 14:59:20 -0700
Message-Id: <20180223215922.25415-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset updates label storage size check and index block size
calculation according to UEFI 2.7 spec.

---
Toshi Kani (2):
 1/2 libnvdimm, label: change min label storage size per UEFI 2.7
 2/2 libnvdimm, label: change nvdimm_num_label_slots per UEFI 2.7

---
 drivers/nvdimm/label.c | 34 ++++++++++++++++++++++++----------
 drivers/nvdimm/label.h |  2 +-
 2 files changed, 25 insertions(+), 11 deletions(-)
