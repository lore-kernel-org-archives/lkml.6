Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932564AbeCITHg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:07:36 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36631 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbeCITHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:07:33 -0500
X-Google-Smtp-Source: AG47ELt9BZdopYpA2EAqbmiSNtQaTe3YQUAb0yqGn+2MqLZ2lUoqjDbML+uYyYsPxomzoaGJAFke3Q==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com, musashino.open@gmail.com
Cc: hauke@hauke-m.de, zajec5@gmail.com, jonmason@broadcom.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: dts: BCM5301X: add missing LEDs for Buffalo WZR-900DHP
Date: Fri,  9 Mar 2018 11:07:28 -0800
Message-Id: <20180309190728.31034-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1520422436-9405-1-git-send-email-musashino.open@gmail.com>
References: <1520422436-9405-1-git-send-email-musashino.open@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Mar 2018 20:33:56 +0900, musashino.open@gmail.com wrote:
> From: INAGAKI Hiroshi <musashino.open@gmail.com>
> 
> Buffalo WZR-900DHP has 8 LEDs, but there is not LED definitions in the
> dts and cannot configure these LEDs.
> I Added missing LED definitions for WZR-900DHP.
> 
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
