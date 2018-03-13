Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2903400-1520939142-2-4396562827785888587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520939141; b=u2A94verTpZq4p21Gb6itUrLWMbVBbkcTc9DgVApFqcQ9PV
    3fSA4I5c4JPqkEp3TrMowBiEt+AODUhqpH9X2iPGf56HvyFUw/PNg3DPcJDBJnz7
    tbzQsxO2027224nxKqeA0xbZwy5zM5akcVVjnA/7RJsBw5P/IBgKAt4ATThOCmII
    3P5N/T3y7Au9hJ4bHGJx/2z/wMm0vtVyhsvSp2vUQ4g8JPt2GAf7oURI0e+rM+bW
    b/aWiTv19vF1oQT+rzblTEhK6Jm38lYEncow10UEEiOQ7XGoFTX9pXw4KG3Gfcz3
    str5lm3qPUQb5ppHjtDZR4NkydOrzPkAiPtugfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520939141; bh=e
    BrcScrN9VWjoNXF8MaJnCn0zWhnWgdpt1WkvHDPopI=; b=Yalan8vJgaP7x8sLP
    +RVRdSMJw80jelnDlWVRgZov5qwYWOqnmtLgJWcyRrHk4x8QITn75DnwLx4ZhSNd
    Q+TEKFPb233vC1CoGOsIj6myYISkjL3R9NG32dbWROsJ5tNgbGYszO03Hi6Ifq8x
    7o0LEQHE7HbdqlXgnQ1nYUPpslcb2RvdLbHhDoR0MqFtIGKabgauKI4vZUfOLlu9
    f7xvG5rBjy0yUGvP9E90Il+G8lxonbmFxiLlFjNBqsxO8v7PrAGc9uNOllW75uOL
    kfFtZHl/BeMvEWgzRgIEC2EyY3bZ+bgXlR1sb/ABa7AqHx+PJnT9qilvqhjj1hGQ
    izX4g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,464,1515481200";
   d="scan'208";a="9663660"
Date: Tue, 13 Mar 2018 16:35:26 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv2] staging: wilc1000: use pre-defined macro
 is_broadcast_ether_addr
Message-ID: <20180313163526.617216de@ajaysk-VirtualBox>
In-Reply-To: <20180313095816.GA1656@kroah.com>
References: <20180312093903.9147-1-hariprasath.elango@gmail.com>
 <20180313130051.43b087dd@ajaysk-VirtualBox>
 <20180313095816.GA1656@kroah.com>
Organization: Microchip Techonology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, vbabu3@visteon.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 hariprasath.elango@gmail.com, Ganesh Krishna <ganesh.krishna@microchip.com>,
 aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 10:58:16 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Mar 13, 2018 at 01:00:51PM +0530, Ajay Singh wrote:
> > 
> > Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>
> > 
> > On Mon, 12 Mar 2018 15:09:03 +0530
> > <hariprasath.elango@gmail.com> wrote:
> >   
> > > From: HariPrasath Elango <hariprasath.elango@gmail.com>
> > >  
> > 
> > Please avoid use of 'From' tag specially when there is only one
> > 'Signed-off-by' tag and its same.  
> 
> But the email client isn't putting the correct info in the email header,
> so this line is needed.
> 
> And if it's redundant, not a problem, git handles it just fine, better
> to be safe.


Thanks Greg, for giving the information.
In that case, we can keep the 'From:' tag to be on safe side.


Regards,
Ajay
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
