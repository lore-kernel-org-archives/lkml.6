Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeEUOrR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:47:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38889 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752735AbeEUOrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:47:12 -0400
Date: Mon, 21 May 2018 16:47:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <vokac.m@gmail.com>
Cc: netdev@vger.kernel.org, michal.vokac@ysoft.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        mark.rutland@arm.com, robh+dt@kernel.org, davem@davemloft.net
Subject: Re: [PATCH net-next 1/7] net: dsa: qca8k: Add QCA8334 binding
 documentation
Message-ID: <20180521144711.GE8077@lunn.ch>
References: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
 <1526909293-56377-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526909293-56377-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:28:07PM +0200, Michal Vokáč wrote:
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Hi Michal

It would be good to document that fixed-link can be used.

   Andrew
