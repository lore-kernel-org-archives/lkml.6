Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeDUTf3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 15:35:29 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:46174 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753158AbeDUTf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 15:35:27 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 21 Apr 2018 21:35:26 +0200
X-ME-IP: 90.55.212.125
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 29/61] mtd: devices: simplify getting .drvdata
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <20180419140641.27926-30-wsa+renesas@sang-engineering.com>
X-URL: http://belgarath.falguerolles.org/
Date: Sat, 21 Apr 2018 21:35:21 +0200
In-Reply-To: <20180419140641.27926-30-wsa+renesas@sang-engineering.com>
        (Wolfram Sang's message of "Thu, 19 Apr 2018 16:05:59 +0200")
Message-ID: <87o9icxshy.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Sang <wsa+renesas@sang-engineering.com> writes:

> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
