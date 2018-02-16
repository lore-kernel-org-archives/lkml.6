Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeBPDif (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 22:38:35 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34827 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeBPDhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 22:37:50 -0500
X-Google-Smtp-Source: AH8x224RQPZaTsKkkOPqnDceRyu/CDnSKMnCZ1xpflu5rzbS2zWOO38+3jzx8Ee7Ie+PvEz+YZYKTA==
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 0/3] taint: Add taint for randstruct
Date: Thu, 15 Feb 2018 19:37:41 -0800
Message-Id: <1518752264-47238-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up the taint flags and documentation before adding a new
one for randstruct. Patch 3/3 reads:

Since the randstruct plugin can intentionally produce extremely unusual
kernel structure layouts (even performance pathological ones), some
maintainers want to be able to trivially determine if an Oops is coming
from a randstruct-built kernel, so as to keep their sanity when debugging.
This adds the new flag and initializes taint_mask immediately when built
with randstruct.

Thanks,

-Kees
