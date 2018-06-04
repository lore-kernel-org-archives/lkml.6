Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeFDRu0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:50:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750985AbeFDRuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:50:25 -0400
Date: Mon, 4 Jun 2018 12:50:19 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 4.18
Message-ID: <20180604175019.GA25169@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-4.18

These three commits fix and clean up the flags dlm was
using on its SCTP sockets.  The result improves the
performance and fixes some bad connection delays.

Thanks,
Dave

Gang He (3):
      dlm: fix a clerical error when set SCTP_NODELAY
      dlm: make sctp_connect_to_sock() return in specified time
      dlm: remove O_NONBLOCK flag in sctp_connect_to_sock

 fs/dlm/lowcomms.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)
