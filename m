Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbeEaWFJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:05:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34183 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750711AbeEaWFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:05:08 -0400
X-ME-Proxy: <xmx:knEQW4jdqG4-lDHPgjZ8Coo1uRlrBG5Ukl9a_BbhvLLSRihdOofb6Q>
X-ME-Proxy: <xmx:knEQW-aTyGO8hQ_k3SWGCXbYMh0zjy2VuSBlORmLEu_l3xrtzpEZIQ>
X-ME-Proxy: <xmx:knEQW-_okQKl8Xb90vmZzYzoE8vFmg77Re9nTXBs4d3yW0hsIkck5A>
X-ME-Proxy: <xmx:knEQWyf5T8WKCx7U3NTK3cs2Q-9TwtbBH2A8LU3MPXUrijrdnpguzQ>
X-ME-Proxy: <xmx:knEQW5krqQXhs-lGkSztDmeqevSR47_aFcvf-0A_7shApt5hR2gv3A>
X-ME-Proxy: <xmx:k3EQW6gjj-phd8EXuDimTQ6pDEtvdOJGvIPcRMjCsdxxb1qYsp42Vg>
X-ME-Sender: <xms:knEQW970YvpaZS1q7bjP5HJmueLq5ukEtBRNM2MDBai60JF9L08Org>
Date: Thu, 31 May 2018 19:05:03 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Ivan Ivanov <qmastery16@gmail.com>
Cc: Josh Boyer <jwboyer@kernel.org>,
        Sherry Hurwitz <sherry.hurwitz@amd.com>,
        Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Rudolf Marek <r.marek@assembler.cz>, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 1/1] Update AMD cpu microcode for family 15h
Message-ID: <20180531220503.2jqs3oiqsnw7ye2t@khazad-dum.debian.net>
References: <1527213479-121361-1-git-send-email-sherry.hurwitz@amd.com>
 <CA+5PVA7aPRHk=kfxsmPi-qStKEnK_HJ=rTjvtQGO1QbnLb9qBw@mail.gmail.com>
 <CAAaskFAGRUU3APZbsY2w9hW9jbBJfeMbHt8ttg7vXHidp025=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAaskFAGRUU3APZbsY2w9hW9jbBJfeMbHt8ttg7vXHidp025=g@mail.gmail.com>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018, Ivan Ivanov wrote:
> This is still not addressing the outdated 15h microcode version issue
> that Rudolf Marek has pointed out. Also, we still hope to see an
> updated microcode for 16h architecture as well - it has not received
> any updates for two years already

True, but now at least it won't regress old boxes anymore, so we can
ship it in the stable branches of the distros with less restrictions.

It would be really good to be able to actually mitigate spectre v2/v4 on
most AMD systems, though.  And current experience shows this is only
going to happen if we can have the required microcode update also going
through the operating system update channels.

-- 
  Henrique Holschuh
