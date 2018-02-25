Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeBYVSk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 16:18:40 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:33691 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBYVSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 16:18:39 -0500
X-Google-Smtp-Source: AH8x224+WSDc8aCn/6XEmb4MGpHZ9PMHh2BkisCaaLhEHAOe/K/sVuX3sdE8lV/b/U1eQGk739PATXtoOkJVOd9MqcM=
MIME-Version: 1.0
In-Reply-To: <20180225150505.GD7144@yexl-desktop>
References: <20180225150505.GD7144@yexl-desktop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Feb 2018 13:18:38 -0800
X-Google-Sender-Auth: a2bqmAybwkhs1TYXvSb9mxf3528
Message-ID: <CA+55aFzRAn=7km3xNn2BKjsLAc=SOma584tYnzD+nanab8H_Hw@mail.gmail.com>
Subject: Re: [lkp-robot] [iversion] c0cef30e4f: aim7.jobs-per-min -18.0% regression
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Jeff Layton <jlayton@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 7:05 AM, kernel test robot
<xiaolong.ye@intel.com> wrote:
>
> FYI, we noticed a -18.0% regression of aim7.jobs-per-min due to commit:
>
> commit: c0cef30e4ff0dc025f4a1660b8f0ba43ed58426e ("iversion: make inode_cmp_iversion{+raw} return bool instead of s64")

That looks very unlikely.  Can you double-check that? Because it
shouldn't even change anything apart from trivial compiler instruction
selection.

             Linus
