Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-198351-1525861267-2-1470599261322061804
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01,
  UNPARSEABLE_RELAY 0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: to='utf-8', plain='iso-8859-1'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525861266; b=cp8QSDM2DxS6f9fP/NCn76cooOQwcEs7iwuzPDNaqggw1cjnP+
    yf0gOuOfzuWeDGaeNmlSg4AHl3rFezRxWBWeTZWBLbgKnh3Tc6SnvmFMVysy2Iss
    V9VfZa/GU2ouCTTh/xgQhQ8dIieSMwUrXLDe4MykHlvK7TZ2S/hXzMc6Ib5UdZ84
    8wpA/vi9Z3Kk2ti49zWMX+38S44Kc78wubhQDuN47fwE92koC2czmD5xzLXHlOgf
    vaFA9ryjF2wfhyEqqeQUO2tP/Y6upexOvIcklofl3RFEyA0By2KVoV36dfhLt0Du
    HEHXcsILhFjAL1X3b4jUM/LmTZqH7Hr52Imw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525861266; bh=4NCkewKgOcVdmY9UzMQVkPvqcKqDBO
    Ay/ogAcWI1fh8=; b=TkWMWAGQri7n0eWgWMZg6B5e/VX1p3LRtFUovYNz78mR15
    aDAWdPL1ZhJS/wignZriMunzG/DTqDkBUGNSP+BcJ6LRZ/xj7hJY0wFfqcAmz7kL
    7R4CPON2FE4IIA2OBJxMb21OTb1nz5u2ZokpjM0rJ+dCOUCUK1ezVkQxsZAjqav5
    IT+Hip4QtdFR32HHIm/Y1I0f5kxBi0ZuL4nDc3J2mcka4ZEU1tWYzY8Ec2qlwjMI
    QXURs4oeQhtKSNpm8+kPIvwO8vGcKe2m7n8gPHRl7W/3W6VSXh0pQCNYjkeLu18I
    dvL/aetUwMV4FS3o1pserGUKf+Cl2YHQrkrFCTPQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=collabora.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-49 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=collabora.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAAPdyeRNeau7JMWAPulBhajBMhdw2bvTcVbxur9dyyUJvc1yohMtqgCaP72U/b9lUNbJC+eRzMYCQ32Cano0DTMCuvV7EpOQEdOQTiXHFPoaT9JVPN6
    28YlW6tj1eKU+p2WX/xtaiz1/tPbGDwSr2EJAX23gYkuLHETsUCfuCySiB73S6r8HZSeK2nAnateJ1HxVWpR3pxR0Xwba9l62TQIMzFvi0TrdcqBvL9a1OCk
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=OScXe70xAAAA:8
    a=gvl4HP8tAAAA:8 a=Jpa4zIKWZXDKiyRWNJMA:9 a=wPNLvfGTeEIA:10
    a=CqWAb0ANQdc9hd79StMA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10 a=X7_D5SgixhGjaE2bLVSS:22
    a=tRkgsvjveJ3YVe9fnr1q:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933869AbeEIKVE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 06:21:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54400 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933819AbeEIKVC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 May 2018 06:21:02 -0400
Date: Wed, 9 May 2018 12:20:58 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Message-ID: <20180509102058.6mshag4y7aq4w2n2@earth.universe>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
 <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
 <20180508134047.zocurxwelw3a24ti@earth.universe>
 <20180508184612.iixr3psap4ik5fdr@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l23cwsfinxziuvyc"
Content-Disposition: inline
In-Reply-To: <20180508184612.iixr3psap4ik5fdr@pengutronix.de>
User-Agent: NeoMutt/20180323
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--l23cwsfinxziuvyc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 08, 2018 at 08:46:12PM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, May 08, 2018 at 03:40:47PM +0200, Sebastian Reichel wrote:
> > On Tue, May 08, 2018 at 08:43:51AM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Mon, May 07, 2018 at 11:36:10PM +0200, Sebastian Reichel wrote:
> > > > This properly unmaps DMA SG on device shutdown.
> > > >=20
> > > > Reported-by: Nandor Han <nandor.han@ge.com>
> > > > Suggested-by: Nandor Han <nandor.han@ge.com>
> > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > > ---
> > > >  drivers/tty/serial/imx.c | 12 ++++++++++--
> > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > index 3ca767b1162a..6c53e74244ec 100644
> > > > --- a/drivers/tty/serial/imx.c
> > > > +++ b/drivers/tty/serial/imx.c
> > > > @@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_p=
ort *port)
> > > >  	u32 ucr1, ucr2;
> > > > =20
> > > >  	if (sport->dma_is_enabled) {
> > > > -		sport->dma_is_rxing =3D 0;
> > > > -		sport->dma_is_txing =3D 0;
> > > >  		dmaengine_terminate_sync(sport->dma_chan_tx);
> > > > +		if (sport->dma_is_txing) {
> > > > +			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> > > > +				     sport->dma_tx_nents, DMA_TO_DEVICE);
> > > > +			sport->dma_is_txing =3D 0;
> > > > +		}
> > >=20
> > > did you find this because the kernel crashed or consumed more and more
> > > memory, or is this "only" a finding of reading the source code? If the
> > > former it would be great to point out in the commit log, if the latte=
r,
> > > I wonder if this is a real problem that warrants a stable backport.
> >=20
> > A bit of both. One of Collabora's customers had a (scarce) kernel crash
> > in imx-serial and modified multiple things in the driver. The crash is
> > gone, but it's not clear which change fixed it. I could not
> > reproduce the crash so far and I'm currently rebasing and splitting
> > their changes into upstreamable portions with proper patch
> > descriptions. From reading the source this looked like a real issue.
>=20
> In which context (kernel version, operating mode (e.g. rs485)) did these
> happen? What does "crash" mean? The kernel did just hang or produced an
> oops? If the latter, can you show it/them?

I pasted the oops, that triggered writing the patches (Linux 4.8, no
rs485, 4MHz baudrate). I think, that the actual issue has already been
fixed upstream between 4.13 and current master.

-- Sebastian

=2E..
[  302.516696] Unhandled fault: external abort on non-linefetch (0x1008) at=
 0xf0938000
[  302.524394] pgd =3D 80004000
[  302.527111] [f0938000] *pgd=3Dde81a811, *pte=3D53fc0653, *ppte=3D53fc0453
[  302.533451] Internal error: : 1008 [#1] SMP ARM
[  302.537994] Modules linked in: smsc95xx usbnet atmel_mxt_ts
[  302.543651] CPU: 0 PID: 357 Comm: _ACFRead Not tainted 4.8.0 #1
[  302.549578] Hardware name: Freescale i.MX53 (Device Tree Support)
[  302.555679] task: edbf1f00 task.stack: ed5ce000
[  302.560228] PC is at imx_rxint+0x5c/0x228
[  302.564261] LR is at lock_acquired+0x494/0x57c
=2E..
[  303.055953] Backtrace:
[  303.058430] [<804b3b48>] (imx_rxint) from [<804b4df8>] (imx_int+0x2ec/0x=
404)
[  303.065484]  r10:00000000 r9:00000000 r8:00000030 r7:00000030 r6:0000509=
9 r5:00007240
[  303.073406]  r4:eeafdc10
[  303.075975] [<804b4b0c>] (imx_int) from [<80182f10>] (__handle_irq_event=
_percpu+0x4c/0x3e8)
[  303.084331]  r10:00000000 r9:810025c4 r8:00000030 r7:00000001 r6:ee81c21=
0 r5:ee81c200
[  303.092252]  r4:edcbe040
[  303.094814] [<80182ec4>] (__handle_irq_event_percpu) from [<801832d8>] (=
handle_irq_event_percpu+0x2
c/0x68)
[  303.104472]  r10:1240dc08 r9:00000001 r8:ee81e400 r7:00000001 r6:ee81c21=
0 r5:ee81c200
[  303.112393]  r4:ee81c200
[  303.114954] [<801832ac>] (handle_irq_event_percpu) from [<8018335c>] (ha=
ndle_irq_event+0x48/0x6c)
[  303.123832]  r5:ee81c260 r4:ee81c200
[  303.127454] [<80183314>] (handle_irq_event) from [<80186ba0>] (handle_le=
vel_irq+0xb8/0x154)
[  303.135810]  r7:00000001 r6:ee81c210 r5:ee81c260 r4:ee81c200
[  303.141547] [<80186ae8>] (handle_level_irq) from [<80182420>] (generic_h=
andle_irq+0x30/0x44)
[  303.149990]  r7:00000001 r6:00000000 r5:00000030 r4:80ff1e8c
[  303.155728] [<801823f0>] (generic_handle_irq) from [<801827a0>] (__handl=
e_domain_irq+0x60/0xc8)
[  303.164439] [<80182740>] (__handle_domain_irq) from [<80101530>] (tzic_h=
andle_irq+0x74/0x9c)
[  303.172882]  r9:00000001 r8:ed5cfae8 r7:00000001 r6:00000020 r5:8108a50c=
 r4:00000000
[  303.180734] [<801014bc>] (tzic_handle_irq) from [<8094c630>] (__irq_svc+=
0x70/0x98)
[  303.188311] Exception stack(0xed5cfae8 to 0xed5cfb30)
[  303.193374] fae0:                   00000283 edbf23c0 edbf1f00 600b0113 =
edbf2458 00000004
[  303.201563] fb00: 00000014 00000004 818762ec edbf23c8 1240dc08 ed5cfb94 =
eee55200 ed5cfb38
[  303.209748] fb20: 00000282 80177d1c 600b0113 ffffffff
[  303.214805]  r9:ed5ce000 r8:818762ec r7:ed5cfb1c r6:ffffffff r5:600b0113=
 r4:80177d1c
[  303.222649] [<80177a50>] (lock_release) from [<8094bba0>] (_raw_spin_unl=
ock+0x28/0x34)
[  303.230572]  r10:00000008 r9:ed5a5500 r8:eeafdc10 r7:ef07c000 r6:0000000=
0 r5:edb86f40
[  303.238493]  r4:8101bd68
[  303.241057] [<8094bb78>] (_raw_spin_unlock) from [<8025fdb4>] (remove_vm=
_area+0x54/0x70)
[  303.249153]  r5:edb86f40 r4:edb86100
[  303.252771] [<8025fd60>] (remove_vm_area) from [<8025fdfc>] (__vunmap+0x=
2c/0xf8)
[  303.260173]  r5:f0c0b000 r4:f0c0b000
[  303.263791] [<8025fdd0>] (__vunmap) from [<8026000c>] (vunmap+0x50/0x5c)
[  303.270497]  r7:ef07c000 r6:00001000 r5:f0c0b000 r4:00000000
[  303.276240] [<8025ffbc>] (vunmap) from [<805262e4>] (dma_common_free_rem=
ap+0x64/0x74)
[  303.284076]  r5:20000008 r4:f0c0b000
[  303.287697] [<80526280>] (dma_common_free_remap) from [<80117404>] (cma_=
allocator_free+0x7c/0x84)
[  303.296574]  r7:ef07c000 r6:00000000 r5:00001000 r4:effd9f80
[  303.302312] [<80117388>] (cma_allocator_free) from [<80116dcc>] (__arm_d=
ma_free+0xf0/0x13c)
[  303.310668]  r7:ef07c000 r6:f0c0b000 r5:f0c0b000 r4:edb869c0
[  303.316405] [<80116cdc>] (__arm_dma_free) from [<80116e78>] (arm_dma_fre=
e+0x2c/0x34)
[  303.324153]  r5:edcc2010 r4:80116e4c
[  303.327779] [<80116e4c>] (arm_dma_free) from [<8047dba8>] (sdma_free_cha=
n_resources+0xc4/0x110)
[  303.336490] [<8047dae4>] (sdma_free_chan_resources) from [<8047a9d8>] (d=
ma_chan_put+0x88/0xbc)
[  303.345107]  r7:600b0113 r6:00000000 r5:edcc07ec r4:edcc07ec
[  303.350845] [<8047a950>] (dma_chan_put) from [<8047aa44>] (dma_release_c=
hannel+0x38/0xa8)
[  303.359028]  r5:edcc07ec r4:edcc07ec
[  303.362647] [<8047aa0c>] (dma_release_channel) from [<804b3e1c>] (imx_ua=
rt_dma_exit+0x50/0xfc)
[  303.371263]  r5:edcc07ec r4:eeafdc10
[  303.374882] [<804b3dcc>] (imx_uart_dma_exit) from [<804b5028>] (imx_shut=
down+0x118/0x20c)
[  303.383065]  r5:00000b01 r4:eeafdc10
[  303.386689] [<804b4f10>] (imx_shutdown) from [<804ae834>] (uart_shutdown=
+0x120/0x17c)
[  303.394525]  r7:81031774 r6:ee8863a4 r5:eeafdc10 r4:ee886258
[  303.400264] [<804ae714>] (uart_shutdown) from [<804b0624>] (uart_close+0=
x164/0x254)
[  303.407926]  r9:ed5a5500 r8:ee8863ac r7:ee886310 r6:eeafdc10 r5:edba9800=
 r4:ee886258
[  303.415768] [<804b04c0>] (uart_close) from [<80492300>] (tty_release+0x1=
04/0x498)
[  303.423256]  r9:ed5a5500 r8:00000000 r7:ee00e000 r6:00000000 r5:eeac2e60=
 r4:edba9800
[  303.431100] [<804921fc>] (tty_release) from [<80271404>] (__fput+0x98/0x=
1e8)
[  303.438154]  r10:00000008 r9:eeac2e60 r8:00000000 r7:ee00e000 r6:edebea1=
0 r5:eeac2e60
[  303.446075]  r4:ed5a5500
[  303.448635] [<8027136c>] (__fput) from [<802715c4>] (____fput+0x18/0x1c)
[  303.455342]  r10:ed5cfedc r9:ed496780 r8:edbf1f00 r7:edbf2340 r6:8108b05=
4 r5:00000000
[  303.463263]  r4:edbf2300
[  303.465832] [<802715ac>] (____fput) from [<80146034>] (task_work_run+0xc=
8/0xf8)
[  303.473165] [<80145f6c>] (task_work_run) from [<801265e0>] (do_exit+0x33=
0/0xb74)
[  303.480567]  r9:edfd07dc r8:00000000 r7:81084dcc r6:810025c4 r5:81083a25=
 r4:edbf1f00
[  303.488408] [<801262b0>] (do_exit) from [<80128678>] (do_group_exit+0x4c=
/0xcc)
[  303.495636]  r7:00000009
[  303.498205] [<8012862c>] (do_group_exit) from [<80135450>] (get_signal+0=
x2a8/0x990)
[  303.505866]  r7:00000009 r6:00418004 r5:ed5cfec8 r4:ed5eeca0
[  303.511616] [<801351a8>] (get_signal) from [<8010c6e4>] (do_signal+0xd8/=
0x47c)
[  303.518844]  r10:00000000 r9:ed5ce000 r8:00000001 r7:766d443c r6:766d443=
8 r5:ed5cfec8
[  303.526764]  r4:ed5cffb0
[  303.529326] [<8010c60c>] (do_signal) from [<8010cc78>] (do_work_pending+=
0xc0/0xd0)
[  303.536901]  r10:00000000 r9:ed5ce000 r8:801086c4 r7:801086c4 r6:ed5cffb=
0 r5:ed5ce000
[  303.544824]  r4:00000001
[  303.547385] [<8010cbb8>] (do_work_pending) from [<80108548>] (slow_work_=
pending+0xc/0x20)
[  303.555568]  r7:0000008e r6:747ad088 r5:747ad188 r4:747ad188
[  303.561306] Code: e5943094 e594202c e2833001 e5843094 (e592a000)
[  303.567419] ---[ end trace 741daf1a1655e1be ]---
[  303.572048] Kernel panic - not syncing: Fatal exception in interrupt
[  303.578432] ---[ end Kernel panic - not syncing: Fatal exception in inte=
rrupt
=2E..

--l23cwsfinxziuvyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlryy4cACgkQ2O7X88g7
+po2+A/+KfO8czc/AdEethEmYjTZdyU3cV3Amj9WyA4MZyxANc9jDDg8cODyvEoU
3ivpHcBxabc2Ed+Na6WqmOibw1nY2JiQVWBj1NaOzNB/KhoTrKTE7MTad/JTpJpt
u6ReYPmSoWhKj4Z6CWWS2jtUxk8GtCkkAW6AC5kSwlVNBys6ompWrnojUcuZIIid
QyvsTWF4zeJtCKIGM6mSeCGmOqUaVuXo766pFeAW5YIoa/EU6kN6yUiKlNiOprHI
RYEDHr+iz08rnwZ+JOzFSg57nyRJb3k7cgRTjg/HFICtVooODB6Gd4qkruAPS1VU
yTF0rmjhYSpveTJUYPQ8Gheupf1HP/iN1INtY3iw0QW7tOnRCisZQT68/fsOCgEb
fWZt3gLk0bWu8JNbkFVS2lO6hb9kb1sG2Gu/YWlOmZpy3JWbyCJptgySaJp3cEGt
qu+koMVOkI7FeMOhE54kZm6p+ewBtWu7On+UBUZAJVh7tm1n77G8rbNSaDPXx1gf
xeACB3cCAbigOitnQbfO3RA27h+Rs2Vn/aapkbmoSz1pPdpMSpNJBE0UDfCb8w/+
IUtLbAtrnNQQptyIrjx/2NT5pCh9HLyGH69H/8c9t7EmoalLet84SJ1FYi4zERkb
J+PTMjuE8k6qS03TBiXo71lsMtzRL1ir2TjMC7tsOHMT8dOobTc=
=yhBK
-----END PGP SIGNATURE-----

--l23cwsfinxziuvyc--
