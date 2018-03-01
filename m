Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935784AbeCAHur (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 02:50:47 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:35293 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934908AbeCAHup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 02:50:45 -0500
X-Google-Smtp-Source: AG47ELuPpyw/7AIX6fFAaMln4ibzgxWYs+vV3DAE7mF0r+RHl8R2SzTzOF3zss0yL1Ex7ixQBye86g==
From: Progyan Bhattacharya <bprogyan@gmail.com>
X-Google-Original-From: Progyan Bhattacharya <progyanb@acm.org>
Message-ID: <1519890640.7987.0.camel@acm.org>
Subject: Re[v2]: Use of GCC plugin instead ISO C
To: Progyan Bhattacharya <bprogyan@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 01 Mar 2018 13:20:40 +0530
In-Reply-To: <1519310261.20003.1.camel@acm.org>
References: <1518941218.12663.1.camel@gmail.com>
         <7bd655df-39a1-2098-0d1c-256c0900b7ed@infradead.org>
         <1519310261.20003.1.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-22 at 20:07 +0530, Progyan Bhattacharya wrote:
> On Sun, 2018-02-18 at 08:47 -0800, Randy Dunlap wrote:
> > You could try (re)building with V=1 on the "make" command line and
> > capture
> > the output to see where the "pedantic" is coming from.
> 
> This is a late reply.
> I did what you told me and the build failed at following point:
> 
> 	/bin/sh: /home/progyan/Programs/Linux/tools/objtool/.objtool-
> in.o.cmd: Permission denied
> 
> I am not sure what permission it wants or what to make of it.
> 
> Thanks in advance.

-- 
Regards,
Progyan Bhattacharya
(http://codeprogyan.me)
