Return-Path: <giulio.benetti@micronovasrl.com>
X-Google-Smtp-Source: AB8JxZqZ9yxeKz5LggnFoLnchWTqFOgfCm3VdlFQxMufgVsPyKJ7gPb2/jy1gfO5ZgDizI09kiyp
ARC-Seal: i=1; a=rsa-sha256; t=1526485095; cv=none;
        d=google.com; s=arc-20160816;
        b=L+iX0t8BghHd1CPvbvRZlqSvl1ddeZVag3gBZ7RpKvsmDfImP/VOOSnzKFMGAWe6tj
         ak6XURA+0qAr4UhTJLrW/CI39E1ewus92OF/gIt6k18oQZQvTH9QP9VC1c9IkT7+dQNy
         uelaeRonS63Bv7StLjcBAPIX/QXMSRqHEDaj7aLKic5KsQPCNdup4Xn5+1wLKmcEVo5+
         5ylTKtW5M4gqL6DFSHu5qQUZHYbPf/gvTcKIS4CBcnNgNrpG9IPpYa2P3GVN60bHmgHq
         dJjjcF4NPse2SMZebRrEw5pdQvRhWQ3Zm9O3pRb1QB8NxxJ3A8/RFpYqUJ//F4N/1305
         LY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=L8nakm+iyiWNI9aVShl/x8PKGAEt4g9x3Mt4KLsjRK8=;
        b=RoK/W5hJNHtcsjzot2TTq0dL+qFIYiDixwejWEyKQJ631DGMu3R6OMLGwAvF+cZCut
         WdZ+c+102a6V5JwY0uJkb9v97z5+eFsjbtXCQCdsgu+NKzJAKIRoLeRYQY3s7KChMN2g
         KWQivKajcilfKCpKz+L4nG155vUnezWLhvcIVvVfeCmxrVau48Gagpx6Gq+Z8niSBSQt
         F+syAqnVgj1Rw9dC6ghAtkUixAdPTpjlC/UA8DBzaBO0Tsi7wcZlUp96hy5BbWZjSrca
         imwnV0KWrctyukNqjbKCgUkONzFaGSvgFf5hi2+ZuBwRQkJmcpRhCJzQo0uh98cV5XQC
         utjw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=temperror (no key for signature) header.i=@micronovasrl.com header.s=dkim header.b=Xo7QLn2I;
       spf=pass (google.com: domain of giulio.benetti@micronovasrl.com designates 212.103.203.10 as permitted sender) smtp.mailfrom=giulio.benetti@micronovasrl.com
Authentication-Results: mx.google.com;
       dkim=temperror (no key for signature) header.i=@micronovasrl.com header.s=dkim header.b=Xo7QLn2I;
       spf=pass (google.com: domain of giulio.benetti@micronovasrl.com designates 212.103.203.10 as permitted sender) smtp.mailfrom=giulio.benetti@micronovasrl.com
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.899
Subject: Re: [PATCH] tty: fix typo in ASYNCB_FOURPORT comment
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@linutronix.de, pombredanne@nexb.com, kstewart@linuxfoundation.org,
 linux-kernel@vger.kernel.org
References: <20180516143931.89679-1-giulio.benetti@micronovasrl.com>
 <20180516153622.GA23725@kroah.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <0073aeb2-15b6-cf2d-91a5-8e05f535793d@micronovasrl.com>
Date: Wed, 16 May 2018 17:38:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516153622.GA23725@kroah.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600631959743697096?=
X-GMAIL-MSGID: =?utf-8?q?1600635635282521492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Il 16/05/2018 17:36, Greg KH ha scritto:
> On Wed, May 16, 2018 at 04:39:31PM +0200, Giulio Benetti wrote:
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   include/uapi/linux/tty_flags.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Sorry, but I can't take patches without any changelog text at all.
> Please fix up and resend.

Sure.
Thanks

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
