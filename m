Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A705C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580B4214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeLRGnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:43:14 -0500
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:28021
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726316AbeLRGnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:43:13 -0500
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 1C09820778;
        Tue, 18 Dec 2018 06:43:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Dec 2018 07:43:11 +0100
From:   Martin Schiller <ms@dev.tdt.de>
To:     John Crispin <john@phrozen.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: xway: fix gpio-hog related boot issues
Organization: TDT GmbH
In-Reply-To: <f84d3544-417d-182e-2dd1-8a79585c40e5@phrozen.org>
References: <20181214074825.6976-1-ms@dev.tdt.de>
 <CACRpkdaTR-Bb6MBtP34GCEtjqfxSNr5PQjDZ_PFqX2B+odGu-w@mail.gmail.com>
 <f84d3544-417d-182e-2dd1-8a79585c40e5@phrozen.org>
Message-ID: <aaa1ff6b4b6c18168fc9caf803aa253b@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-17 17:45, John Crispin wrote:
> On 17/12/2018 15:32, Linus Walleij wrote:
>> On Fri, Dec 14, 2018 at 8:48 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>>> This patch is based on commit a86caa9ba5d7 ("pinctrl: msm: fix 
>>> gpio-hog
>>> related boot issues").
>>> 
>>> It fixes the issue that the gpio ranges needs to be defined before
>>> gpiochip_add().
>>> 
>>> Therefore, we also have to swap the order of registering the pinctrl
>>> driver and registering the gpio chip.
>>> 
>>> You also have to add the "gpio-ranges" property to the pinctrl device
>>> node to get it finally working.
>>> 
>>> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
>> Patch applied unless John Crispin has objections, it looks
>> good to me!
>> 
>> Yours,
>> Linus Walleij
> 
> 
> sorry did not see the patch in my inbox
> 

Sorry, that was my fault.
I've added everyone from getmaintainers.pl output, but forgot to also 
add you.

Regards,
Martin
