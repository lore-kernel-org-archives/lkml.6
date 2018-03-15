Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeCORqs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:46:48 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55674 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCORqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:46:46 -0400
X-Google-Smtp-Source: AG47ELtpohe9YxCTyvro8BraeJFmlpWPYMaYgHUJtW/wKHKTqLnXaK02BpAwgBDKTP4I5IvAYZnTBKjpD9GkNmzGgRc=
MIME-Version: 1.0
In-Reply-To: <1078e19a-3393-7cd9-3b1f-fae6cf0281d3@intel.com>
References: <20180225150505.GD7144@yexl-desktop> <1519573271.4702.10.camel@redhat.com>
 <1078e19a-3393-7cd9-3b1f-fae6cf0281d3@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 10:46:45 -0700
X-Google-Sender-Auth: Qf96m0zSLJEe1s3byC3PB3YjczY
Message-ID: <CA+55aFypsiFknaNaWQP8rRacNiZLW8sEfU150L0uHF_t8=-3UA@mail.gmail.com>
Subject: Re: [LKP] [lkp-robot] [iversion] c0cef30e4f: aim7.jobs-per-min -18.0% regression
To: kemi <kemi.wang@intel.com>
Cc: Jeff Layton <jlayton@redhat.com>,
        kernel test robot <xiaolong.ye@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 12:33 AM, kemi <kemi.wang@intel.com> wrote:
> Hi, Jeff
>    Today, I deleted the previous kernel images for commit 3da90b159b146672f830bcd2489dd3a1f4e9e089
> and commit c0cef30e4ff0dc025f4a1660b8f0ba43ed58426e, respectively. And, re-run the same aim7
> jobs for three times for each commit. The aim7 score between two commit does not have obvious difference.
>
> Perhaps something weird happen when compiling kernel. Please ignore this report, apologize for the bother.

Ok, I'm not entirely happy with how random this was, but that commit
never looked like a remotely likely culprit, so I think we'll just
chalk it up to bad luck and unknown effects.

                Linus
