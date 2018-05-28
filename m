Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934016AbeE1Ukr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:40:47 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39749 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeE1Ukp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:40:45 -0400
X-Google-Smtp-Source: AB8JxZqvyeKFuKRbs70FKS3YrpkKVfhSIXL5ln+Crq5qnJCYzTf/PsyAc9uGayPnKVCCprRUPIXu6w==
From: Phillip Hugo <egnuph@googlemail.com>
X-Google-Original-From: Phillip Hugo <phill@gnu.org>
Message-ID: <1527540057.30075.21.camel@gnu.org>
Subject: Linux and autoconfig of kernel on iso-image boot.
Reply-To: egnuph@gmail.com
To: linux-kernel@vger.kernel.org
Date: Mon, 28 May 2018 21:40:57 +0100
Organization: GNU's Not UNIX
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, thanks for your work.

Linux should have "make grab_config" that sets loaded modules to be
built in the kernel build and make modules.

Obviously this is so when you boot for the first time, a fully stocked
kernel of modules, your first kernel build will have sensible settings
for your system already.

It should be in the Kernel bundle as every derived system need it.

Thanks and kind regards

Phillip
