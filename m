Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeEaDj0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:39:26 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38743 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932653AbeEaDjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:39:23 -0400
X-Google-Smtp-Source: ADUXVKILZ9GDMsx8HOwSUzgCFDGMaQ12j71f4vSyNgYYVerRqbtXeldj+0DNxmUD7L5yWj7c2jj96A==
Date: Wed, 30 May 2018 22:39:21 -0500
From: Rob Herring <robh@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Mark Rutland <mark.rutland@arm.com>, limor@ladyada.net,
        Nitin Patil <nitin@mindsensors.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: new binding for Ilitek ILI9341
 display panels
Message-ID: <20180531033921.GA31521@rob-hp-laptop>
References: <20180525193623.15533-1-david@lechnology.com>
 <20180525193623.15533-4-david@lechnology.com>
 <c4ee580a-4adf-278f-1be4-be4e5cb53660@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ee580a-4adf-278f-1be4-be4e5cb53660@lechnology.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 03:14:33PM -0500, David Lechner wrote:
> On 05/25/2018 02:36 PM, David Lechner wrote:
> > This adds a new binding for Ilitek ILI9341 display panels. It includes
> > a compatible string for one display (more can be added in the future).
> > 
> > The vendor prefix "noname" is used because the vendor is not known.
> 
> Looks like I forgot to update "noname" to "adafruit" in the commit message.
> Patch is as intended though.

Other than that,

Reviewed-by: Rob Herring <robh@kernel.org>
