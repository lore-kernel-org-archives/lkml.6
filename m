Return-Path: <alan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpR7rjn4E+ZI/2LOmuB7zVB7+hV2+f9F8JEQ9Ub22o4jGqUDfZSOmMoD4i0l+BWHOfZunfP
ARC-Seal: i=1; a=rsa-sha256; t=1526052676; cv=none;
        d=google.com; s=arc-20160816;
        b=QCVusjsTdDcGj8cGgH0AcS+G1S/K0WKkGpOJVHeSo3Qr/man6djzwS4czp/Qtr3f5U
         EZl8o6MkeoMgxmac9ESq9VnxxDszzvSfHsCCT6LmnBD1ecPTkfxux0rZfBEYYx2ktGOz
         FWhxTVNHB/xE0PIbT1cdAlEhtx3LvyqHLsNGCg8ve0VeczbLJTJdNMKlpbkohkPLegG9
         PbsA6KohPhLLlaOrABTiOeng/T7cq6XOXB7jkMQeHurHLjdpNjXVBaiXGHRk/QqJkSsa
         opEO5C/RRRSAsrDh05qnEz144xKHSZVAu6yP7rv+3wIiNdulQU3tCfyiDU5B7Sv7TfUw
         Hf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=+Q3NpR3P+12E3sBnvkWp8xibaE4Ftr+uoUIH3LX45I4=;
        b=hPBe8H03o68UD9NgiYZifeS9/CzM4UwWw9Ml12j0HFdFKrHBz/jkDZuz6b0NNpcXgR
         IsBcw4rBSAFHFSudVqVIA4GtJzSVreyn655Ek3GCm9xm1h89NWdogRzVqZ/hxIj7A4kj
         YgZctg6bbxKX7/LAsfs0fN/bjeeNyaA6itEVbBwrKuINQZFraelYmAT1ap6oRxtyJqG5
         ICYR9EMRoIGqDxWQFN+u8Gu+IhUOvEsmxbdXp6dhNjBSepvsOtSHJr/PbEtNeJi1iRTS
         OIUmPEwzXRTv+8E/o7nk8avxk4ZDWdnIdl6JrGJoZEVEAoZXzoahMPe3BZh1btMk7j6O
         NtRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of alan@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=alan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of alan@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=alan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,389,1520924400";
   d="scan'208";a="41035283"
Message-ID: <1526052671.26291.58.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] media: staging: atomisp: Fix an error handling path
 in 'lm3554_probe()'
From: Alan Cox <alan@linux.intel.com>
To: Julia Lawall <julia.lawall@lip6.fr>, Christophe JAILLET
	 <christophe.jaillet@wanadoo.fr>
Cc: sakari.ailus@linux.intel.com, mchehab@kernel.org,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 chen.chenchacha@foxmail.com, keescook@chromium.org,
 arvind.yadav.cs@gmail.com,  linux-media@vger.kernel.org,
 devel@driverdev.osuosl.org,  linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Date: Fri, 11 May 2018 16:31:11 +0100
In-Reply-To: <alpine.DEB.2.20.1805111709390.20118@hadrien>
References: <cover.1526048313.git.christophe.jaillet@wanadoo.fr>
	 <f762630a681c08d9903cf73243dd98416ae96a7c.1526048313.git.christophe.jaillet@wanadoo.fr>
	 <alpine.DEB.2.20.1805111709390.20118@hadrien>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600180660963930909?=
X-GMAIL-MSGID: =?utf-8?q?1600182211329589465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-05-11 at 17:09 +0200, Julia Lawall wrote:
> 
> On Fri, 11 May 2018, Christophe JAILLET wrote:
> 
> > The use of 'fail1' and 'fail2' is not correct. Reorder these calls
> > to
> > branch at the right place of the error handling path.
> 
> Maybe it would be good to improve the names at the same time?

Its scheduled for deletion - please don't bother.

Alan
