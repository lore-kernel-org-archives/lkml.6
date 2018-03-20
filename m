Return-Path: <hariprasath.elango@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521547729; cv=none;
        d=google.com; s=arc-20160816;
        b=zIGyilGliTIfmtTB/9Rc+KblxAdOkGQJw9mAHJF8/sj9hdZYXs5mzf9ClBVXOzwx5J
         te4a0/IPp/RTGNWh5dKp8OeTyORxiV+pPukrlS1FkER3EhQhOEza0O0q+PgemIL/xnar
         eYb+PB3R7V1oQ6jD/jM7zl1iIuTDSkuT+spNaNcWlDp1vmiEfTGej0SqintunOp+w4NF
         GfScZls3VjGwEacXIZ8KBi9yb0jpGlEppQWGzcjgYBgT/ZTtiV758m59x5NN/FvyLCAl
         vhMiF1Z6+QDhPxLhUtSA6AA5dyVcupDJ1BWD5y6MwmtNFCVR0GpDSpNUibfGH7HDZuyx
         SYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:dkim-signature
         :arc-authentication-results;
        bh=7OtwoNMXKYv6XfcBPdjvwNOyY57gUF86cBQergyFZVE=;
        b=vr/Fu8t/GQr9gk8TBMTEJEo1OiByl/TrRDEnCUk1QYP1tY03RwjokDHTyadYyAlEBz
         TkvXdInFUEZQwMU8x3j86NeB2CnIf/MlZ+O2MuHd4/EwUNqZ3Uay86cxbV8aMEKXTV8x
         I2RgmCyfVyXoQz/6ZptA2dGyhwqpyY74rL8VWEwkhRldP5ZnfMUVq1rscy8vK+KoYBRb
         vLmYOMblkxntes06TyXT8tRf4W5Wy8bPO7nKXbR2l5j31YT5ymO9vx3AdVrNRFGuRhez
         gj0Mr4DDt7FM10enzUrUQF3DyJGhsOa5hMDI3agVBeaua2vE4YrBKFwFAwaT2qKu5V6c
         SNwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=M8s460BD;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=M8s460BD;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtyEAUlKrCv5wQRWgDyRhsADtsjs+7vTQ5oGfs/AsTiTNWx6XSWrQuv2IY5iDjTvfXP55o6IA==
From: "<Hariprasath Elango>" <hariprasath.elango@gmail.com>
X-Google-Original-From: "<Hariprasath Elango>" <hariprasath.elango>
Date: Tue, 20 Mar 2018 17:38:42 +0530
To: Greg KH <gregkh@linuxfoundation.org>
Cc: hariprasath.elango@gmail.com, aditya.shankar@microchip.com,
	ganesh.krishna@microchip.com, dan.carpenter@oracle.com,
	gehariprasath@gmail.com, linux-wireless@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] staging: wilc1000: replace switch statement by simple
 if condition
Message-ID: <20180320120842.GB4033@hariprasath>
References: <20180320114331.4084-1-hariprasath.elango@gmail.com>
 <20180320114720.GA31253@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320114720.GA31253@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594917172280071605?=
X-GMAIL-MSGID: =?utf-8?q?1595458432328321512?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 12:47:21PM +0100, Greg KH wrote:
> On Tue, Mar 20, 2018 at 05:13:31PM +0530, hariprasath.elango@gmail.com wrote:
> > From: HariPrasath Elango <hariprasath.elango@gmail.com>
> > 
> > In this case,there is only a single switch case statement.So replacing
> > by a simple if condition
> > 
> > Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> > ---
> >  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> What changed from v1?  Always put that information below the --- line,
> like the kernel documentation asks you to do.
> 
> v3?  :)
> 
> thanks,
> 
> greg k-h

Lesson learned. I will send a v3 with version history included

regards,
hari prasath
