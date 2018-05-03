Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZonmGvN8O774wTsv5ZCW3dRbQAoSHsM5sm/x+qOWJROjYSU3Djvpgw9YgWQxhiXic+yM5vt
ARC-Seal: i=1; a=rsa-sha256; t=1525390297; cv=none;
        d=google.com; s=arc-20160816;
        b=ZXIjIcC3qCJHCDFzr29gqqEt9KRY8699M1oNfvtb8/X87eRf6MRfPO0Oq+Jp17wUm+
         hm6GrylWbBzL8vpsmSeaXZX25Faojs+UuxekAcssv5i7GbkHwnrLGjaWf9BMu9n5J8l2
         U3VewbdjgzznTFedHT6A3MVK4Ll/pbUObYJeHAzE34HCHESdYmxyr8VPbu8Mvl81OkAB
         554IJpmE0zktGZwm1etDD0bYBxr3BOU0LQfcdK9zANddbZ/yaFaEcrP6+DSm7uJTM1yb
         3k9C6a9yDzoJcBEvDQHlXgnREIr2J1uopxxHiv8Li3jViawJ9hzWBAD6UmHMm+SdvQXJ
         V53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=UP9VTCIKXiYF3PlTxOXjLG5ZyeUlXnM/33G5n9SRNws=;
        b=GqhFd2psbVihJj3ErS2IF0LG7JxjXLzBOfAVlG4JkIlRPSI73qo7VfUEf9FPhV77R+
         JCzK0g7M52U7CD84RlQeW4asSJ/90vm1V/XqPW6jVdwQsiILVkuzfHNYQ5CZZofR0OLC
         aeOz8PxGxd8Atpdt4h6WeVgJoEJ/9nFBkPHSUUHimydkdr3VQxI0hFNfBC36F+BbDlEx
         gpXnzowdy3PyFQ49KYVnECSvHE/FDJDoynB3SCX6Ec7r1/l884jPBLKh7oslYka5BdoQ
         5YW8/QhrRYgcJiYyFE1bmQvXmlb2eqScvyQKcDMago8fifVKkrpkim9RghrO8sxl6Pdc
         +G9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 3 May 2018 23:31:35 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, alexdeucher@gmail.com, christian.koenig@amd.com,
	kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	hdegoede@redhat.com, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/9] firmware: some documentation fixes
Message-ID: <20180503233135.GG27853@wotan.suse.de>
References: <20180423201205.20533-1-andresx7@gmail.com>
 <20180423201205.20533-2-andresx7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423201205.20533-2-andresx7@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569144299276165?=
X-GMAIL-MSGID: =?utf-8?q?1599487656798655454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 04:11:57PM -0400, Andres Rodriguez wrote:
> Including:
>  - Fixup outdated kernel-doc paths
>  - Slightly too short title underline
>  - Some typos
> 
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>

This already got merged.
