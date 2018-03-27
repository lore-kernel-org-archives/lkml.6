Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeC0Wnw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:43:52 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44451 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbeC0Wnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:43:50 -0400
Date: Wed, 28 Mar 2018 00:43:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Subject: Re: [PATCH v3 0/2] of_net: Implement of_get_nvmem_mac_address helper
Message-ID: <20180327224348.GA23320@lunn.ch>
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
 <20180323151101.GB24361@lunn.ch>
 <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
 <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 11:52:24AM +0200, Mike Looijmans wrote:
> Posted this as a small set now, with an (optional) second patch that shows
> how the changes work and what I've used to test the code on a Topic Miami board.
> 
> v3: Add patch that implements mac in nvmem for the Cadence MACB controller
>     Remove the integrated of_get_mac_address call
> 
> v2: Use of_nvmem_cell_get to avoid needing the assiciated device
>     Use void* instead of char*
>     Add devicetree binding doc

Hi Mike

This looks good now, thanks.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
