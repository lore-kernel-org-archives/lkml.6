Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeCHTyU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:54:20 -0500
Received: from mail-pl0-f44.google.com ([209.85.160.44]:43136 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeCHTyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:54:16 -0500
X-Google-Smtp-Source: AG47ELv6eNdVr9wLnax/6kA+Eu+QiNPG1D1uXS6c5BLEwuhqsJIJ3yOC2KOfvbd2vvq3kh0piNl/nw==
From: Kevin Hilman <khilman@baylibre.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-amlogic@lists.infradead.org, Carlo Caione <carlo@caione.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: meson-sm: rework meson_sm_init to use module_platform_driver_probe
Organization: BayLibre
References: <1520336869-25224-1-git-send-email-sudeep.holla@arm.com>
Date: Thu, 08 Mar 2018 11:54:14 -0800
In-Reply-To: <1520336869-25224-1-git-send-email-sudeep.holla@arm.com> (Sudeep
        Holla's message of "Tue, 6 Mar 2018 11:47:49 +0000")
Message-ID: <7hd10efimx.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sudeep Holla <sudeep.holla@arm.com> writes:

> Commit 3aa0582fdb82 ("of: platform: populate /firmware/ node from
> of_platform_default_populate_init()") takes care of populating
> all the devices under the /firmware/ node in of_platform_default_populate_init()
>
> This patch reworks meson_sm_init to use module_platform_driver_probe as
> the platform device is populated.
>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-amlogic@lists.infradead.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

I gave this a spin through kernelCI.org, and it passed fine on several
amlogic boards, so queuing for v4.17.

Thanks,

Kevin
