Return-Path: <hns@goldelico.com>
X-Google-Smtp-Source: AB8JxZqGr3svwpl/QH++hfGeJJ3nNWWyIioUweDu4ZosWA3tVvnvat72QsaU1lAVKlSRjwZ/FJLh
ARC-Seal: i=1; a=rsa-sha256; t=1525340124; cv=none;
        d=google.com; s=arc-20160816;
        b=Ek/zE+7H9v24fvoBrtD2BFZd1baJXP5Q3ys9mvPKdZT8SAfwik55/ZupnR9G7mpJEe
         Yy61i5uxuEhTcXN2bpzh/HP3F0GLs7KnlGoxLeA7QXHm1pN6bqLEzl0g7A51rLJqiO6E
         rCdCarFnun2Hu9AKrWw1P17tlLhyj9qPXsVx7aFztvvYqzxVnqCWBvcLb8Bomb9ZNdF/
         H3MEjOpOLgzEX9QWMMKZCnSZYOAL+N5TDj1t37j5rn9IdzXaEHVIV3RorouY5XlR5Yu1
         IY4B27NgEBck3GVZjgKTVcShoIwUs80PIO6JNSedzYfeplRP6tOPAK1t1L0AAtsKwGNN
         xdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=7INNERHV1VMzTUZKH5bm9OrWNfhr6vXDWKe5PXN08zo=;
        b=ucDKPf8yfgoB5DxSypCoOPzgYL+fNCaSiN8KnZZl0weqpwr1cgOtZTXoF11jfFDwde
         JL+Ruo4gYG5K2/UhcHplkBXQnBK08NiE8bXaA/XcXdadFznj++gEX8HBbtx621z4XNiw
         NOx9nnzEO0a8FSHyN6XHKUQfbSsT3Xe8/DEbSPUZwHXHACmUXWhxofwHKLF6wKQqOZMC
         aNveoOuD/HyolqP9FlPdmUqxVapIbnM5mOgCBqP0zOM+mb2JXzEAglaIqCNkKZ464mRb
         j6fSFFRkqJUjtusyBZYR/NgYbALZxVxe9bqwgOaiYvOEBUFNLB8HLcnJIIVPgG4X+zxg
         YIcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=BLf/Mt4x;
       spf=neutral (google.com: 2a01:238:20a:202:5301::10 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=BLf/Mt4x;
       spf=neutral (google.com: 2a01:238:20a:202:5301::10 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN1FD6Y"
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
From: H. Nikolaus Schaller <hns@goldelico.com>
In-Reply-To: <20180502081637.GE2285@localhost>
Date: Thu, 3 May 2018 11:35:21 +0200
Cc: Mark Rutland <mark.rutland@arm.com>,
 Andreas Kemnade <andreas@kemnade.info>,
 Arnd Bergmann <arnd@arndb.de>,
 Pavel Machek <pavel@ucw.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
References: <20180424163458.11947-1-johan@kernel.org> <20180424163458.11947-5-johan@kernel.org> <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com> <20180426091018.GU4615@localhost> <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com> <20180502081637.GE2285@localhost>
To: Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3124)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599435046065189112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Am 02.05.2018 um 10:16 schrieb Johan Hovold <johan@kernel.org>:
>=20
> On Tue, May 01, 2018 at 09:05:42AM -0500, Rob Herring wrote:
>> On Thu, Apr 26, 2018 at 4:10 AM, Johan Hovold <johan@kernel.org> =
wrote:
>>=20
>> Though with the enable-gpios I was debating the name for sirfstar a
>> bit because it isn't the normal drive it active to enable, but rather
>> a pulse to enable or disable.
>=20
> I had some concerns along those lines as well, and if you agree I'll
> change the property name to on_off-gpios (or onoff-gpios) which =
matches
> the vendor data sheets for this pin, and which I think would be =
better.

In our original submission of our w2sg bindings we also did call that
"on-off-gpios", but Rob suggested to use the standard way of =
"enable-gpios":

https://patchwork.kernel.org/patch/9738981/

We changed this and got his acked-by for our w2sg bindings:

https://patchwork.kernel.org/patch/10054911/

We also have found an agreed wording for the description:

- enable-gpios:  the GPIO that controls the module's power toggle
         input. A positive impulse of sufficent length toggles the
         power state.

But what should I expect from someone who constantly ignores, rejects
and belittles previous work of others and prefers to reinvent almost
the same thing and claims that it is 100% original work?

I am so heavily upset this time because we had been asked by reviewers =
if
it was not Neil Brown who laid the foundation and yes, we of course =
looked
how to formulate proper attribution:

https://patchwork.kernel.org/patch/10059705/

I stand to my view that this is a good example how to ruin the =
willingness
of volunteers to send submissions for review, since the paycheck a =
volunteer
receives uses the currency of being welcome, recognition and visibility =
in
the final git log.

And I had expected that reviewers from kernel.org are more =
generous/liberal
with code flaws (finding them is IMHO the sole purpose of the review =
process)
and don't expect that everyone has the same background.

Anyways, let's forget this type of discussion and come back to a =
technical
level:

I have realized that the w2sg0004 is an exception (although a Sirf chip)
that it does not provide a WAKEUP signal. And another significant
difference is that we have to keep the serdev UART enabled even if there
is no user-space client. Otherwise we are not able to detect unexpected
activity. So we unfortunately can't move serdev open/close into the =
.open
and .close ops but need to open it in probe.

Therefore, it is in my opinion still better to have a separate driver =
for
the w2sg0004 instead of hacking the support of this chip into your =
WAKEUP
capable sirfstar driver. So I suggest that you make WAKEUP a required
property.

We had faced a comparable decision last year with the ov9650 and ov9655 =
camera
sensors which are almost the same. But not same enough to integrate both =
into
a single driver.

So (despite my grown doubts about the review process), I'll now submit a =
v7
of our w2sg0004 driver, adjusted to your gnss framework API and tested =
on
GTA04 hardware. It is only covering the w2sg0004 module and not even =
claiming
to handle the w2sg0084(i) to avoid overlap with your work.

BR,
Nikolaus
