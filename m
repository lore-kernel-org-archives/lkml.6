Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93449C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680BF21873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfBZUtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:49:42 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45042 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfBZUtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:49:42 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id DAEB45400C1;
        Tue, 26 Feb 2019 23:49:39 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Denis Efremov <efremov@ispras.ru>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] LSM documentation update
Date:   Tue, 26 Feb 2019 23:49:01 +0300
Message-Id: <cover.1551213058.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent "New LSM Hooks" discussion has led me to the
thought that it might be a good idea to slightly
update the current documentation. The patchset adds
nothing new to the documentation, only fixes the old
description of hooks to reflect their current state.

V2 adds the clarification on arguments for some hooks.
The format of the documentation is also slightly updated
for better html. However, there are still 10 hooks without
documentation at all. I think that this should be fixed
separatedly.

Denis Efremov (11):
  LSM: fix documentation for sb_copy_data hook
  LSM: fix documentation for the syslog hook
  LSM: fix documentation for the socket_post_create hook
  LSM: fix documentation for the task_setscheduler hook
  LSM: fix documentation for the socket_getpeersec_dgram hook
  LSM: fix documentation for the path_chmod hook
  LSM: fix documentation for the audit_* hooks
  LSM: fix documentation for the msg_queue_* hooks
  LSM: fix documentation for the sem_* hooks
  LSM: fix documentation for the shm_* hooks
  LSM: lsm_hooks.h: fix documentation format

 include/linux/lsm_hooks.h | 170 ++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 89 deletions(-)

-- 
2.17.2

