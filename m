Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965335AbeBWS5J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:57:09 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42945 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965312AbeBWS5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:57:05 -0500
X-Google-Smtp-Source: AG47ELuG3kvpDElnQJ9Y0FZ6h8sFQ2kBSS9RQvooQG14LNlS6FCSVLpPKiZpLTEqR0AX4/ddzEiefQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <mmayer@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc: ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] memory: brcmstb: dpfe: support new way of passing data from the DCPU
Date: Fri, 23 Feb 2018 10:57:00 -0800
Message-Id: <20180223185700.16821-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1518554440-21805-4-git-send-email-mmayer@broadcom.com>
References: <1518554440-21805-1-git-send-email-mmayer@broadcom.com> <1518554440-21805-4-git-send-email-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 12:40:40 -0800, Markus Mayer <mmayer@broadcom.com> wrote:
> The DCPU can now send message data in two ways:
>   - via the data RAM, as before (this is now message type 0)
>   - via the message RAM (this is message type 1)
> 
> In order to support both methods, we check the message type of the
> response (bits 31:28) and then treat the offset (bits 27:0)
> accordingly.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/fixes, thanks!
--
Florian
