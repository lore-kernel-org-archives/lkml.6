Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeBFVG6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:06:58 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:37853 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeBFVG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:06:56 -0500
X-Google-Smtp-Source: AH8x2250tSo4NFpEvI/lisCWUcIhTmZvH+g77NBlKto7K30TwRWYbNKuh7Nq0QN1X3N2guJ8+lRlzg==
Date: Tue, 6 Feb 2018 13:06:53 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] igb: Fix a test with HWTSTAMP_TX_ON
Message-ID: <20180206210653.qjqmbxyqsdw43t3w@localhost>
References: <20180206194759.26991-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206194759.26991-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 08:47:59PM +0100, Christophe JAILLET wrote:
> 'HWTSTAMP_TX_ON' should be handled as a value, not as a bit mask.
> The modified code should behave the same, because HWTSTAMP_TX_ON is 1
> and no other possible values of 'tx_type' would match the test.
> However, this is more future-proof, should other values be allowed one day.

Nice catch, and I am going to introduce more tx_type values soon.

Thanks,
Richard
