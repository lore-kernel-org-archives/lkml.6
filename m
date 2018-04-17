Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeDQHZp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:25:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39964 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751183AbeDQHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:25:44 -0400
Message-ID: <1dfacb56f2ab9a1a38a7cb78326a4f96973cf622.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Colin King <colin.king@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Apr 2018 10:06:33 +0300
In-Reply-To: <20180411130533.11827-1-colin.king@canonical.com>
References: <20180411130533.11827-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.156.4.241
X-SA-Exim-Mail-From: luca@coelho.fi
Subject: Re: [PATCH][next] iwlwifi: mvm: remove division by size of
 sizeof(struct ieee80211_wmm_rule)
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on farmhouse.coelho.fi)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-11 at 14:05 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The subtraction of two struct ieee80211_wmm_rule pointers leaves a
> result
> that is automatically scaled down by the size of the size of pointed-
> to
> type, hence the division by sizeof(struct ieee80211_wmm_rule) is
> bogus and should be removed.
> 
> Detected by CoverityScan, CID#1467777 ("Extra sizeof expression")
> 
> Fixes: 77e30e10ee28 ("iwlwifi: mvm: query regdb for wmm rule if
> needed")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, Colin! I've pushed this to our internal tree for review and if
everything goes fine it will land upstream following our normal
upstreaming process.

--
Cheers,
Luca.
