Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeFDUas (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:30:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43751 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeFDUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:30:45 -0400
X-Google-Smtp-Source: ADUXVKLFvR8DH2G3z3m1mgsP2xsZIv3j+S3xw9XaaNWO0G/psGyI3xGuqGsOV7s//oVRSgHmtb+RIA==
Subject: Re: [PATCH] riscv/ftrace: Fix the problem modules cannot find _mcount
Date: Mon,  4 Jun 2018 13:30:27 -0700
Message-Id: <20180604203028.13886-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <1525749717-384-1-git-send-email-alankao@andestech.com>
References: <1525749717-384-1-git-send-email-alankao@andestech.com>
Cc: linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: alankao@andestech.com, linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've rewritten the commit message to match what this patch actually
does.  Assuming it's OK, I'll include it as part of the commits for this
merge window.

Thanks!
