Return-Path: <samuel.thibault@ens-lyon.org>
X-Google-Smtp-Source: AB8JxZrsb9GAKoEkQ1nhyD8+KizajfBmf/mpEta6ItRUOPSNbpxnxJjMtwTgv+iY+mMBeKSdSDOV
ARC-Seal: i=1; a=rsa-sha256; t=1525788266; cv=none;
        d=google.com; s=arc-20160816;
        b=h6nVhmvAWNGBEZjM647tmgrVMu/clCpbdp4cXwDLw/IeqyMOv5Xx/103z/bs1MCKXO
         wSeTnnNR4Sv5yXR9PGiSB2HoK2ngCep8ZU1JjKCyvFCuJOxIkVoZ+JGL6jrnVd8JnY1Z
         sEpTf+C35dULnXm/OmoUn2aimADL9msWvQbrBjeZbhHMpNV3W58AObwZ3W7bO+wsoe9Q
         lup3YC7yAEZnHjL17RVhPXBOQxcuIMK2lAHFZvFhFuAZrnatXW8dqlYseDjwaVnFzuQC
         YL7DTR6G+3/Vr4wg4StbWVf+sAEFtCVTVdM6tq+ZDKPmvrBSgqIsrQKzi5ePsZlvz4K1
         qSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:arc-authentication-results;
        bh=NbdUEcVWa6lytMX4X3CHxtsODUqtgcvbbQThZ4sWf6o=;
        b=Fi2tsEDirm4cVQiP/iNDPvpRm1MHJeP9uRPwD/8XUlReDRN3GWLDmE2FML6DbIEx4F
         qZrwEaJM1x63+Bq3hv4Om+PvkINIOIAwAI+6Vl1LhmdITC5/EfXYhYboIRhMuYKq5qUH
         +FHG4J0HHKWVQlGdnG93k6UuTN4klpz1mCjfWLdOfOnKenCDZhQbYarAlsuCwqgZfr1f
         N/2NbWVMV2wBdRihjbxCKFQLzMfUrnPPcWBzeC5VzqV3MDYvCZ8azrctI3fRFF3cB+dr
         QAaeSV/8k1qUNPx2G7DBkT2rxPVMlEPEmk30HSZQ1xKjeqLE5VeOcbnNgv9bx2IXSQ6S
         x/8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a0c:e300::1 is neither permitted nor denied by domain of samuel.thibault@ens-lyon.org) smtp.mailfrom=samuel.thibault@ens-lyon.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a0c:e300::1 is neither permitted nor denied by domain of samuel.thibault@ens-lyon.org) smtp.mailfrom=samuel.thibault@ens-lyon.org
Date: Tue, 8 May 2018 16:04:24 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	speakup@linux-speakup.org
Subject: Re: [PATCHv2] staging: speakup: Add pause command used on switching
 to graphical mode
Message-ID: <20180508140424.u3z3vp6ctjdiskse@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg KH <gregkh@linuxfoundation.org>, w.d.hubbs@gmail.com,
	chris@the-brannons.com, kirk@reisers.ca, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, speakup@linux-speakup.org
References: <20180507201427.hv5xncif3afs5roj@var.youpi.perso.aquilenet.fr>
 <20180508113131.GA6218@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508113131.GA6218@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599837643714047366?=
X-GMAIL-MSGID: =?utf-8?q?1599904957436479536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg KH, le mar. 08 mai 2018 13:31:31 +0200, a ecrit:
> On Mon, May 07, 2018 at 10:14:27PM +0200, Samuel Thibault wrote:
> > For software speech syntheses to be able to manage concurrent audio card
> > access, they need to know when speakup stops emitting text to be spoken
> > because the console has switched to graphical mode.  This introduces a
> > PAUSE command to do so.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > 
> > ---
> > Difference from v1: fix codestyle issues.
> 
> I already applied the v1 version, can you just send a patch for the
> coding style fixes?

Yes, sure, will do.

Samuel
