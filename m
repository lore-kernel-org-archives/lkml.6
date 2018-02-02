Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeBBFUq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 00:20:46 -0500
Received: from mx.socionext.com ([202.248.49.38]:39503 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeBBFUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 00:20:37 -0500
Date: Fri, 02 Feb 2018 14:20:35 +0900
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fbdev: simplefb: add support for 'memory-region' property on DT node
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <2359956.Z9lQWSAgHb@amdc3058>
References: <1516707296-23667-1-git-send-email-hayashi.kunihiko@socionext.com> <2359956.Z9lQWSAgHb@amdc3058>
Message-Id: <20180202142035.CEB7.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej, Rob, Mark,

On Thu, 1 Feb 2018 16:56:08 +0100 <b.zolnierkie@samsung.com> wrote:
> 
> Hi,
> 
> On Tuesday, January 23, 2018 08:34:56 PM Kunihiko Hayashi wrote:
> > Enables 'memory-region' property referring to the memory description on
> > the reserved-memory node in case of devicetree use.
> > If there is no 'reg' property that specifies the address and size of
> > the framebuffer, the address and size written in the memory description
> > on the reserved-memory node can be used for the framebuffer.
> > 
> > Furthermore, the reserved-memory node needs to have "no-map" attributes
> > because simplefb driver maps the region by ioremap_wc().
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> This needs an ACK from Rob or Mark (DT bindings Maintainers).

Thanks for pointing out.

Rob, Mark, would you please confirm the patch?
This patch contains the addition to dt-bindings.

---
Best Regards,
Kunihiko Hayashi
