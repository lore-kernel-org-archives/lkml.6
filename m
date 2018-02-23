Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeBWWYQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 17:24:16 -0500
Received: from muru.com ([72.249.23.125]:58132 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751607AbeBWWYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 17:24:14 -0500
Date: Fri, 23 Feb 2018 14:24:11 -0800
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv5 0/5] Motorola Droid 4 Audio Support
Message-ID: <20180223222411.GD5593@atomide.com>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180223 20:03]:
> Hi,
> 
> This adds audio support to Motorola Droid 4. I dropped the
> regulator from the DT binding as requested by Mark.

Still works for me. Mark, are you happy now with the way
the nodes are set up?

For the binding and driver changes:

Acked-by: Tony Lindgren <tony@atomide.com>

Then I'll be picking up the dts related patches after
no more comments.

Regards,

Tony
