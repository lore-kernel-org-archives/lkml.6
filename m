Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeEEA3p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 20:29:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37213 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeEEA3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 20:29:43 -0400
X-Google-Smtp-Source: AB8JxZqUy7WFNbgmePHd1Lt/l/FkoAo3kO20gkgh2MxJFrssQNMKRBlH/H8Dlryq6aVmMFQDildd1w==
Date: Fri, 4 May 2018 17:29:40 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ramon Fried <rfried@codeaurora.org>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>
Subject: [GIT PULL] remoteproc and rpmsg fixes for v4.17
Message-ID: <20180505002940.GG17344@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rproc-v4.17-1

for you to fetch changes up to 93dd4e73c0d9cc32f835d76a54257020b0bfc75a:

  rpmsg: added MODULE_ALIAS for rpmsg_char (2018-04-25 16:46:55 -0700)

----------------------------------------------------------------
remoteproc and rpmsg fixes for v4.17

Fixes screw up when reversing boolean for rproc_stop(), add missing of
node dereferences and add missing MODULE_ALIAS in rpmsg_char.

----------------------------------------------------------------
Arnaud Pouliquen (1):
      remoteproc: fix crashed parameter logic on stop call

Ramon Fried (1):
      rpmsg: added MODULE_ALIAS for rpmsg_char

Tobias Jordan (1):
      remoteproc: qcom: Fix potential device node leaks

 drivers/remoteproc/qcom_q6v5_pil.c   | 2 ++
 drivers/remoteproc/remoteproc_core.c | 4 ++--
 drivers/rpmsg/rpmsg_char.c           | 2 ++
 include/linux/remoteproc.h           | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)
