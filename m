Return-Path: <sds@tycho.nsa.gov>
X-Google-Smtp-Source: AH8x225NOnYSwozEXX+1jZV98gqFL+SJL7D7eDNznksjngHPNPcKGrf9H2eBftjANJBve2IjNp1X
ARC-Seal: i=1; a=rsa-sha256; t=1517504471; cv=none;
        d=google.com; s=arc-20160816;
        b=FcUvfok2qRu8IfRYuL5EfaEo5Zzw8g7eEgKve8tGdpxVxQKZVUuwDn6dpF0wwrD8Wf
         /DUo9zyGtuvUBkdCb/cBL2yimtuSCzThOad70kZSSMnP2tFrANGfP1O72YjlEJCdR1yh
         YTe3/Gg0o3vSR0qi5nNKmA3uSAi9vZtseGvmmDBmt4jrOyyNTO7o2mnQo9vTKloiTgWV
         P33w1zjxUtKNnlfCKioUlvdEoWs0KBrDwywRS2vad9T37OXStIAAbwhHVKKN+MSOnFLN
         /hvDtX2P1S6p94Cvq96j0yFZjH/i2Lnp985KLoUEbotgZiGusvxdBukGmpAhnoXRRzl+
         Crhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:ironport-phdr
         :arc-authentication-results;
        bh=syKAwSgd2Qeoql6LfqA6XvlNX3VRWKGOi4khKQ8aTJI=;
        b=eeos2Ma75VEXXqVjpNQGAHtqqdv0InKHswUP1oGF0A7T5uaqS+Xsqr0DMTeBLkMrfa
         ReXuZg7MBV2mMWFnQ5v+Duf3LXVNjLGDyQWw8JpoWqj3hy7PwHzt6/ZAM97MAEHhJJ7h
         2q3zEAC8AQ5a8Jm7njEBYVx8aMY8reWkWxUp3W2OnLNG+DHdjntRZq6rZrjFo4XHWmlW
         vHuVfCtus3oHa6/L5ckiKso4BlxWolXTQoOuzylBWxa6zKmG8y9wFvNWJ4S9Oa8/byhd
         hJlg0Cdr5kXYG2AGIBnIlRl8DT27qOnZUUsoe1ZTe2nZLLbG1rN3iMBFMOlPV9QjDT9B
         0WXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sds@tycho.nsa.gov designates 214.24.24.84 as permitted sender) smtp.mailfrom=sds@tycho.nsa.gov
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sds@tycho.nsa.gov designates 214.24.24.84 as permitted sender) smtp.mailfrom=sds@tycho.nsa.gov
X-IronPort-AV: E=Sophos;i="5.46,444,1511827200";
   d="scan'208";a="436182220"
X-IronPort-AV: E=Sophos;i="5.46,444,1511827200";
   d="scan'208";a="8238494"
IronPort-PHdr: =?us-ascii?q?9a23=3AR1F+PhMgrdUHN6q1xdcl6mtUPXoX/o7sNwtQ0KIM?=
 =?us-ascii?q?zox0K/j/r8bcNUDSrc9gkEXOFd2Cra4c0KyO7+uxBCQp2tWoiDg6aptCVhsI24?=
 =?us-ascii?q?09vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7?=
 =?us-ascii?q?Ovr6GpLIj8Swyuu+54Dfbx9HiTahb75+Ngm6oAreusQSgYZpN7o8xAbOrnZUYe?=
 =?us-ascii?q?pd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPWY15Nb2tRbY?=
 =?us-ascii?q?VguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RTiu86FmQwLzhS?=
 =?us-ascii?q?wZKzA27n3Yis1ojKJavh2hoQB/w5XJa42RLfZyY7/Rcc8fSWdHUMlRTShBCZ6i?=
 =?us-ascii?q?YYUJAeQKIOJUo5Djq1cSqBezAxSnCuHyxT9SnnL43rA03eQ/Hw/I3gMgEc4Bvn?=
 =?us-ascii?q?Pbo9v6L6oSTeK4wbPUwTjZc/9b2zHw45XIfBA7pvGMWKp9f9fNyUYxDwPFjkuf?=
 =?us-ascii?q?qYr4ND2I0+QCqWyb7+5+WuOvlmUqrBpxrSW0xso3lonIhp4aylDD9SljxoY1Ps?=
 =?us-ascii?q?e3RFR0Yd6jDptdrieXPJZ1TMM6W2xkpSk3x7IctZO7YSQG0ooryhHBZ/CdboSF?=
 =?us-ascii?q?5A/oWvyLLjdinn1lfaqyhxO18Ue91OLxTtK00FNWripdldnMq2wN2wTT6seZTv?=
 =?us-ascii?q?t9+V+s2SqV2ADJ6+FEPFs0mbDHK58h3rEwlp0TvV7FHiDqg0X5kLWadkAl+uis?=
 =?us-ascii?q?8+jnY7PmqYGAN4Jslw3zPasjlta/DOglKAQCQWeW9fqm2LH+5UH5Ra9Fjvwykq?=
 =?us-ascii?q?nXqpDaIsEbq7aiAwBIyYYu8Aq/Dje639QYmnkLNlRFeAmdgITzNFHOJ+74Ae+l?=
 =?us-ascii?q?g1uwiDdr2+zGPrr5D5XPK3jDl63hfax8605H0wczy8pQ55dKBbEAOv7zXVXxtN?=
 =?us-ascii?q?PABB8jLwO02/rnCMl61o4GQmKPHrWWP7jWsVCW/e8vPeaMa5EPuDrnKPgq+eTu?=
 =?us-ascii?q?jXknll8ZZ6Wp2oEXaH+gFPR8P0qZeWbsgssGEWoSpQoxUvbqiFKcXjNIZ3a9Ra?=
 =?us-ascii?q?Y85jU7CYKgF4vMWoetgLmZ1iehApJWfnxGCkyLEXrwaYqEQ+0DaDiTIs96iTEE?=
 =?us-ascii?q?TaKuS5Ug1RG1rA/6z6BoIfbK9SECspLjztd17fXJlR4u7Tx0E9id02aVQmFwn2?=
 =?us-ascii?q?MIQSI23a9mrUxm1FiMzbV4g+ZZFdxP5/JFSwI6NZnBwOxnD9D9RBnMfsmGSFm4?=
 =?us-ascii?q?WNWqGzIxQcwrw98IfUl9H8+ujhfZ3yqlG7UVjaCEBIQo8qLA2Hj8P9hyxGvb1K?=
 =?us-ascii?q?kklVYnQ9VANXG9i65w8AjTAIHJk0GHmKqwaasc2yvN/n+ZzWWSpEFYTBJwUaLd?=
 =?us-ascii?q?UHAQfEvZs9v55kDCT7K1DbQnMw1BydONK6tEbd3pkFNGS+r5N9TCYmKxnGGwCQ?=
 =?us-ascii?q?yPxrOWY4rgY38d0znFCEgYjwAT+m6LNRAkCSe8p2LTFzhuFVPpY0Px/uh+pnS7?=
 =?us-ascii?q?TlIyzw6XdUJhy7u1+hkThfCGTPMTxL0Esj87qzpoBFa9w87WC92YqgplfaVcZ8?=
 =?us-ascii?q?494Vhe2WLaqQN9JJqgIL5mhlMFbQR3sF3h1w9tBoVDj8cqtnUqwxR2Ka6C11NB?=
 =?us-ascii?q?bTyY14jqOrLLMmny4Ayva6nO11HGytmW56MP5e8gq1r5oQGpElMu83Bg09lSyX?=
 =?us-ascii?q?uT+I/GAxYVUZL0Skw37QR1p6nGYikh4IPZzWZsPrOwsj7C2tMoBO0lxw26cNdZ?=
 =?us-ascii?q?LayEDgjyE8wHCMS0NOMqnF2pPVo4O7V3/bQ3d/ivc+qUyajjaP1pmCO0nGJv6Y?=
 =?us-ascii?q?ZxyEWN+2x3Teuem949yuycli6AUC3xxAO5u93zsZhNeDVXG2240yWiD4lUMP5c?=
 =?us-ascii?q?Z4EOXFyyLtW3y9M2vJvkX3pV5Rb3HF8d8NO4chqVKVrm1Etf0lpB8i/vojex0z?=
 =?us-ascii?q?Ehy2JhlaGYxiGbhr24LBc=3D?=
X-IPAS-Result: =?us-ascii?q?A2DcAQCrRnNa/wHyM5BcGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?VLYFbKINgmFBFAQEBBoE0mV+FRQKCMVgUAQEBAQEBAQECAWoogjgkAYJHAQUjB?=
 =?us-ascii?q?FIQCxgCAiYCAlcGARKIDIIcDas4gW06imUBAQEBAQEBAwEBAQEBAQEhgQ+DWoI?=
 =?us-ascii?q?VgQ+CADCDLoMvBIUGgmUFk1qQSZVugh6GI4twSJhfNiKBUCsIAhgIIQ+CZ2CEN?=
 =?us-ascii?q?SM3jEkBAQE?=
Message-ID: <1517504530.1750.55.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2] general protection fault in sock_has_perm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark Salyzyn <salyzyn@android.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, Paul Moore <paul@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Eric Paris
 <eparis@parisplace.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        stable
 <stable@vger.kernel.org>, James Morris <jmorris@namei.org>
Date: Thu, 01 Feb 2018 12:02:10 -0500
In-Reply-To: <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
References: <20180201153708.63506-1-salyzyn@android.com>
	 <CAHC9VhSdR9UGpYhod5xhA76EbSKHzTW5rEiYWMovC0t6gfowig@mail.gmail.com>
	 <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591213513726089492?=
X-GMAIL-MSGID: =?utf-8?q?1591218768832188066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-01 at 08:20 -0800, Mark Salyzyn wrote:
> On 02/01/2018 08:00 AM, Paul Moore wrote:
> > On Thu, Feb 1, 2018 at 10:37 AM, Mark Salyzyn <salyzyn@android.com>
> > wrote:
> > > In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE
> > > socket
> > > flag") and all the associated infrastructure changes to take
> > > advantage
> > > of a RCU grace period before freeing, there is a heightened
> > > possibility that a security check is performed while an ill-timed
> > > setsockopt call races in from user space.  It then is prudent to
> > > null
> > > check sk_security, and if the case, reject the permissions.
> > > 
> > > . . .
> > > ---[ end trace 7b5aaf788fef6174 ]---
> > > 
> > > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > > Signed-off-by: Paul Moore <paul@linuxfoundation.org>
> > 
> > No, in the previous thread I gave my ack, not my sign-off; please
> > be
> > more careful in the future.  It may seem silly, especially in this
> > particular case, but it is an important distinction when things
> > like
> > the DCO are concerned.
> > 
> > Anyway, here is my ack again.
> > 
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > 
> 
> Ok, both Greg KH and yours should be considered Acked-By. Been 
> overstepping this boundary for _years_. AFAIK Signed-off-by is still 
> pending from Stephen Smalley <sds@tycho.nsa.gov> before this can roll
> in.
> 
> Lesson lurned

No, Paul's Acked-by is sufficient, and at most, I would only add
another Acked-by or Reviewed-by, not a Signed-off-by.  Signed-off-by is
only needed when one had something to do with the writing of the patch
or was in the path by which it was merged.

I don't object to this patch but I have a hard time adding another ack
because I don't truly understand the root cause or how this fixes it. 
Let's say sk_prot_free() calls security_sk_free() calls
selinux_sk_free_security() which sets sk->sk_security to NULL, and then
we proceed to free the sksec and then sk_prot_free() frees the sk
itself.  Now another sock is allocated (or perhaps a different object
altogether), reuses that memory, and whatever sk->sk_security happens
to contain is set to non-NULL.  We'll just blithely proceed past your
check and who knows what will happen from that point onward.
