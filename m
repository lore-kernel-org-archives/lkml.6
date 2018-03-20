Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeCTRHS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752014AbeCTRD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:03:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB84421839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521168778-27236-10-git-send-email-david@lechnology.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-10-git-send-email-david@lechnology.com>
Message-ID: <152156543724.183971.9703906314447360197@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8 09/42] dt-bindings: clock: New bindings for TI Davinci PSC
Date: Tue, 20 Mar 2018 10:03:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-03-15 19:52:25)
> This adds a new binding for the Power Sleep Controller (PSC) for the
> mach-davinci family of processors.
> 
> Note: Although TI Keystone has a very similar PSC, we are not using the
> existing bindings. Keystone is using a legacy one-node-per-clock binding
> (actually two nodes if you count the separate reset binding for the same
> IP block). Also, some davinci LPSCs have quirks that aren't handled by
> the keystone bindings, so we would be adding one compatible string per
> clock with quirks instead of just a new compatible string for each
> controller.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
