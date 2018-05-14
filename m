Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755269AbeENQ6e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:58:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36087 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbeENQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:58:33 -0400
Date: Mon, 14 May 2018 18:58:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: jacek.anaszewski@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        xiaotong.lu@spreadtrum.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] leds: Add Spreadtrum SC27xx breathing light
 controller driver
Message-ID: <20180514165822.GC27984@xo-6d-61-c0.localdomain>
References: <392631974080542c43b8e280a225d430d73b5ed4.1526279287.git.baolin.wang@linaro.org>
 <f20d9b010a256b695dbaefedacdf3d29fd4b9674.1526279287.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f20d9b010a256b695dbaefedacdf3d29fd4b9674.1526279287.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-05-14 14:34:51, Baolin Wang wrote:
> This patch adds Spreadtrum SC27xx PMIC series breathing light controller
> driver, which can support 3 LEDs. Each LED can work at normal PWM mode
> and breathing mode.
> 
> Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

ACK.

									Pavel
