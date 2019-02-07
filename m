Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFCC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7E121902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBGMpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:45:04 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60480 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBGMpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:45:04 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id EB7105400A9;
        Thu,  7 Feb 2019 15:45:01 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     linux-security-module@vger.kernel.org
Cc:     Denis Efremov <efremov@ispras.ru>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] LSM documentation update
Date:   Thu,  7 Feb 2019 15:44:48 +0300
Message-Id: <cover.1549540487.git.efremov@ispras.ru>
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

Denis Efremov (10):
  security: fix documentation for the sb_copy_data hook
  security: fix documentation for the syslog hook
  security: fix documentation for the socket_post_create hook
  security: fix documentation for the task_setscheduler hook
  security: fix documentation for the socket_getpeersec_dgram hook
  security: fix documentation for the path_chmod hook
  security: fix documentation for the audit_* hooks
  security: fix documentation for the msg_queue_* hooks
  security: fix documentation for the sem_* hooks
  security: fix documentation for the shm_* hooks

 include/linux/lsm_hooks.h | 127 ++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 66 deletions(-)

-- 
2.17.2

