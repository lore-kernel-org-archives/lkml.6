Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032130AbeEXSHT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:07:19 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:49353 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967377AbeEXSHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:07:16 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 24 May 2018 20:07:15 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 05/13] mtd: rawnand: marvell: remove the dmaengine compat need
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
        <20180524070703.11901-6-robert.jarzmik@free.fr>
        <20180524113006.3d5f393e@xps13>
X-URL: http://belgarath.falguerolles.org/
Date: Thu, 24 May 2018 20:07:11 +0200
In-Reply-To: <20180524113006.3d5f393e@xps13> (Miquel Raynal's message of "Thu,
        24 May 2018 11:30:06 +0200")
Message-ID: <87603dx700.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel Raynal <miquel.raynal@bootlin.com> writes:

> Hi Robert,

Actually, a last time error slipped in this patch here (I'm really doing poorly
on the copy paste side):
+	nfc->dma_chan =	dma_request_slave_channel(&nfc->dev, "data");

This should rather be :
+	nfc->dma_chan =	dma_request_slave_channel(nfc->dev, "data");

Would you grant your ack for the next iteration with this change folded in ?

Cheers.

--
Robert
