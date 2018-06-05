Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeFELgB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:36:01 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33868 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeFELf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:35:59 -0400
X-Google-Smtp-Source: ADUXVKKu/3H3cET6bwR1LPaKC4C7ROBjJioGs3kpAdAVA7x6F4nH6bqUFYwe5222Tv2OojU8iM6iew==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] ksys_mount: check for permissions before resource
 allocation
From: Ilya Matveychikov <matvejchikov@gmail.com>
In-Reply-To: <20180605112641.GN30522@ZenIV.linux.org.uk>
Date: Tue, 5 Jun 2018 15:35:55 +0400
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-Id: <1E519BA2-4198-4255-BAE4-3125C59741A3@gmail.com>
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
 <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
 <20180605112641.GN30522@ZenIV.linux.org.uk>
To: Al Viro <viro@ZenIV.linux.org.uk>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55Ba52G004426


> On Jun 5, 2018, at 3:26 PM, Al Viro <viro@ZenIV.linux.org.uk> wrote:
>> 
>>> On Jun 5, 2018, at 6:00 AM, Ilya Matveychikov <matvejchikov@gmail.com> wrote:
>>> 
>>> Early check for mount permissions prevents possible allocation of 3
>>> pages from kmalloc() pool by unpriveledged user which can be used for
>>> spraying the kernel heap.
> 
> I'm sorry, but there are arseloads of unpriveleged syscalls that do the same,
> starting with read() from procfs files.  So what the hell does it buy?

Means that if all do the same shit no reason to fix it? Sounds weird...
