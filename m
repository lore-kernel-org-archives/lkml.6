Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeBFQPA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:15:00 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:47067 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752528AbeBFQOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:14:53 -0500
Date: Tue, 6 Feb 2018 17:14:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Van Asbroeck <svendev@arcx.com>, Woojung.Huh@microchip.com,
        Tristram.Ha@microchip.com
Cc: f.fainelli@gmail.com, helmut.buchsbaum@gmail.com,
        Maarten.Blomme@flir.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1 0/1] spi_ks8995: use regmap to access chip registers.
Message-ID: <20180206161447.GF12679@lunn.ch>
References: <1517930036-17618-1-git-send-email-svendev@arcx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517930036-17618-1-git-send-email-svendev@arcx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 10:13:55AM -0500, Sven Van Asbroeck wrote:
> v1:
> 	starting point.
> 	is there a way to test-run this on supported devices that I don't
> 		have physical access to - (ks8995, ksz8864) ?
> 
> Sven Van Asbroeck (1):
>   spi_ks8995: use regmap to access chip registers.

Hi Sven

Rather than invest time in this driver, it would be better to look
into writing a DSA driver. There was some effort last year to make the
current microchip DSA driver more generic, but that has gone quiet
recently. Maybe you can talk to Tristram.Ha@microchip.com and
Woojung.Huh@microchip.com

	Andrew
