Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeCLOa7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:30:59 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:58300 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeCLOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:30:58 -0400
From: Richard Weinberger <richard@nod.at>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 0/2] mtd: use put_device() if device_register fail
Date: Mon, 12 Mar 2018 15:32:29 +0100
Message-ID: <3321429.TYNOhWIX1S@blindfold>
In-Reply-To: <4a280604-16f2-776b-d997-d5882af6fe35@gmail.com>
References: <cover.1520592440.git.arvind.yadav.cs@gmail.com> <3975609.gPYExXdWMR@blindfold> <4a280604-16f2-776b-d997-d5882af6fe35@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arvind,

Am Montag, 12. März 2018, 06:51:24 CET schrieb Arvind Yadav:
> On Monday 12 March 2018 01:05 AM, Richard Weinberger wrote:
> > Am Freitag, 9. März 2018, 11:50:47 CET schrieb Arvind Yadav:
> >> if device_register() returned an error! Always use put_device()
> >> to give up the reference initialized.
> >> 
> >> Arvind Yadav (2):
> >>    [PATCH 1/2] mtd: use put_device() if device_register fail
> >>    [PATCH 2/2] mtd: ubi: use put_device() if device_register fail
> > 
> > Uhh, this is not obvious. Does device_register() really always return with
> > a reference held in all (error) cases?
> > 
> > Thanks,
> > //richard
> 
> if device_register() returned an error! Always use put_device()
> to give up the reference initialized.(-- Please see the comment
> for device_register() ). put_device() is able to handle those case
> where it'll not return a reference.

You are right.

For both patches:
Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
