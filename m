Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeEHGmc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:42:32 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:19242 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeEHGma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:42:30 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN1Ez6Y"
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 1/6] dt-bindings: define vendor prefix for Wi2Wi, Inc.
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180507205455.GA28316@rob-hp-laptop>
Date: Tue, 8 May 2018 08:41:45 +0200
Cc: Johan Hovold <johan@kernel.org>, afd@ti.com,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Message-Id: <61FC6AF2-C770-45FF-B2D3-932377FF0C91@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com> <7c03df30ceec8b171ab88787c1ef9556c96b30f6.1525340143.git.hns@goldelico.com> <20180507205455.GA28316@rob-hp-laptop>
To: Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Rob,

> Am 07.05.2018 um 22:54 schrieb Rob Herring <robh@kernel.org>:
> 
> On Thu, May 03, 2018 at 11:35:46AM +0200, H. Nikolaus Schaller wrote:
>> Introduce vendor prefix for Wi2Wi, Inc. for W2SG0004 GPS module
>> and W2CBW003 Bluetooth/WiFi combo (CSR/Marvell).
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>> Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>> 1 file changed, 1 insertion(+)
> 
> Applied this one so you don't have to keep sending it.

Thanks and BR,
Nikolaus
