Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934693AbeCEMbW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:31:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933057AbeCEMbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:31:20 -0500
From: Cornelia Huck <cohuck@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/2] vfio-ccw patches for 4.17
Date: Mon,  5 Mar 2018 13:31:14 +0100
Message-Id: <20180305123116.4301-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5628683cf77bc8dad3336a9b254e55f728f7c70e:

  s390/dasd: set timestamps unconditionally (2018-02-27 08:05:29 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180305

for you to fetch changes up to 9851bc77e62499957567e7c39a5beba7d6de6296:

  vfio-ccw: fence off transport mode (2018-03-01 17:35:50 +0100)

----------------------------------------------------------------
A small documentation update, and reject transport mode requests
(which we don't support).

----------------------------------------------------------------

Cornelia Huck (2):
  vfio-ccw: update documentation
  vfio-ccw: fence off transport mode

 Documentation/s390/vfio-ccw.txt | 79 ++++++++++++++++++++---------------------
 drivers/s390/cio/vfio_ccw_fsm.c |  5 +++
 2 files changed, 43 insertions(+), 41 deletions(-)

-- 
2.13.6
