Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB8FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2792240F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2792240F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHJOHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:07:52 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42251 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeHJOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:07:52 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 64A4D1C0002;
        Fri, 10 Aug 2018 11:38:16 +0000 (UTC)
Message-ID: <ad932296a864b13134c5af6efe7754e5e588314e.camel@hadess.net>
Subject: Re: [PATCH] hid: microsoft: Add rumble support for Xbox One S
 controller
From:   Bastien Nocera <hadess@hadess.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Juha Kuikka <juha.kuikka@gmail.com>
Date:   Fri, 10 Aug 2018 13:38:01 +0200
In-Reply-To: <20180810001714.14659-1-andrew.smirnov@gmail.com>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 17:17 -0700, Andrey Smirnov wrote:
> Add HID quirk driver for Xbox One S controller over bluetooth.
> 
> This driver only adds support for rumble. Standard controller
> functionality is exposed by default HID driver.

Did you manage to make the joypad work without hacks in the Bluetooth
stack[1]?

[1]: https://github.com/ValveSoftware/steamos_kernel/commit/549c3dc10fa3749b3999549a2672b14bf0e9786d

