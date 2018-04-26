Return-Path: <yangbo.lu@nxp.com>
X-Google-Smtp-Source: AIpwx48yIOWdLmgu2aeuWTnvBwX/w0WmMDfYCzxC1WbjZefzLzKfek5f/GDaYeoy4MSUk+vVAdue
ARC-Seal: i=1; a=rsa-sha256; t=1524737861; cv=none;
        d=google.com; s=arc-20160816;
        b=X79jYLHN1hWuw+MoaBnRvvvoHrAqrivEjrQtvAJ4NvkGAnp05yRvqcOD10Hz1Wi6hZ
         AGrv4WJtzvAxWSeYvOP44BUg7VEkLgj8ErakAtflyi1yDX5lyYFfd+q3SiGJwtBOjr2U
         3dFf2VYcCsh5nRU3g5BNG5R1NkFqQ5o3okGAHWvGZ4wABnpPpXGaRvNHZQfPW9wFXCIW
         f12SOpeNhqmWTNB1NavOeADZHgQTPX3KUIRY+1xYmSFslcdD+qmL7Mk2zx7nphofLaOc
         36wmYzYMTpLRCLiOx6+YMOexg5Rm8//rCMrRursXK2E5DYrKhg9E9mg7gvvW9v2+39eE
         yjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=feolRsYNknym0t/kNTDPppBZQ+Gcpj5He4ePhrMEOPc=;
        b=Vk/pSSZA3sYDtsxqjpikBpgPdCKcx1rBc2FCt0jDbL4iB50ub8BDCK/2a6PnqN7UEi
         jzWSZKzfOVKj4ltaUIqX2GvwKQ4/IzWsfaKmZUdOGRZJQMtOIcIzq7Z5m0H96ymRTrfp
         qyP1TGWejURuqbH2DS9zJywhGs2LNg9olgrIIWlM93Ebwzp0WSkv0ietuO2gt9Nz1OEd
         d9uFQiY8DtwkVjqpGDMmFh+azzcXDKT0uSZEEqGTsv4R37FMOhF1cFcEAOMF9dyrvx8i
         k0AzywfsXJIMOmo89VNax5iRlLXlgzmErdgcW4jBjx81epcm6HmkkFFqp2203AkY22Yv
         KBOw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=BQpDhG2T;
       spf=pass (google.com: domain of yangbo.lu@nxp.com designates 40.107.0.86 as permitted sender) smtp.mailfrom=yangbo.lu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=BQpDhG2T;
       spf=pass (google.com: domain of yangbo.lu@nxp.com designates 40.107.0.86 as permitted sender) smtp.mailfrom=yangbo.lu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran
	<richardcochran@gmail.com>, Ruxandra Ioana Ciocoi Radulescu
	<ruxandra.radulescu@nxp.com>
Subject: RE: [PATCH] staging: fsl-dpaa2/eth: Add support for hardware
 timestamping
Thread-Topic: [PATCH] staging: fsl-dpaa2/eth: Add support for hardware
 timestamping
Thread-Index: AQHT3HZv/Y/PznkfA0CVZRkLjjVOL6QRQHeAgAGUuKA=
Date: Thu, 26 Apr 2018 10:17:38 +0000
Message-ID: <DB6PR0401MB25361EE5633F24AA34F0063CF88E0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180425091749.46841-1-yangbo.lu@nxp.com>
 <20180425100345.b5oxgdjyud7t6kzc@mwanda>
In-Reply-To: <20180425100345.b5oxgdjyud7t6kzc@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2501;7:/F+TiHI6F0RcOjxjvQV+v8SDek5kJNbl9FugkNnf90Xd5TGW+lkOTatQJI3Fjf25NQFKF9lw5ibI89lhb40CIFGxx//2owudDgqpfWXzle1dsNDYbnl5oTz1Ze6GuEaiC/FobaRqnvm6RyU6+APRd+VIrWwAnP+kv20ljSBdToket4cCp08cmOnl2MTNDD0U9CCaWcgN2H0b64g/iI8SM+Hhx2X1sx7XJXfObi8Utv7M9BPU3TpSO2RuvlI4Ai6v
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2501;
x-ms-traffictypediagnostic: DB6PR0401MB2501:
x-microsoft-antispam-prvs: <DB6PR0401MB250138962A6A3511BC51194FF88E0@DB6PR0401MB2501.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0401MB2501;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2501;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(13464003)(199004)(186003)(53546011)(54906003)(446003)(476003)(316002)(106356001)(26005)(9686003)(55016002)(6916009)(11346002)(5250100002)(99286004)(68736007)(6506007)(59450400001)(102836004)(86362001)(229853002)(478600001)(7696005)(486006)(6436002)(53936002)(76176011)(74316002)(7736002)(4326008)(2906002)(14454004)(6246003)(105586002)(305945005)(3280700002)(81166006)(33656002)(97736004)(66066001)(8676002)(6116002)(3846002)(2900100001)(39060400002)(5660300001)(81156014)(8936002)(25786009)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2501;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ipwc5jvP1Q5BEqaDO48rszu8aUNeBzx9da/zpw+8LWgPxDKifIVHuXoB6IBUl2mSzu0lFpSfWJ4K1AUmRmi/B9PKNRUt7DlW+JoUAeUjXjSNxHSnlm/ywRiHlPUYEwbq8OSbFcI8iJ0vlWkMBI97G2uQWdb0H3TrLhSnDRfRsbQiIgPwu5MDO0DIs5X9zcr7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 507f77ac-32bc-47be-0e4c-08d5ab5ef044
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507f77ac-32bc-47be-0e4c-08d5ab5ef044
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 10:17:38.8123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2501
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598709231870413604?=
X-GMAIL-MSGID: =?utf-8?q?1598803528078554878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dan,

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Wednesday, April 25, 2018 6:04 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: devel@driverdev.osuosl.org; linux-kernel@vger.kernel.org; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; Richard Cochran
> <richardcochran@gmail.com>; Ruxandra Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>
> Subject: Re: [PATCH] staging: fsl-dpaa2/eth: Add support for hardware
> timestamping
>=20
> On Wed, Apr 25, 2018 at 05:17:49PM +0800, Yangbo Lu wrote:
> > @@ -275,6 +278,16 @@ static void dpaa2_eth_rx(struct dpaa2_eth_priv
> > *priv,
> >
> >  	prefetch(skb->data);
> >
> > +	/* Get the timestamp value */
> > +	if (priv->ts_rx_en) {
> > +		struct skb_shared_hwtstamps *shhwtstamps =3D skb_hwtstamps(skb);
> > +		u64 *ns =3D dpaa2_get_ts(vaddr, false);
> > +
> > +		*ns =3D DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS * le64_to_cpup(ns);
>=20
> This will cause Sparse endianess warnings.
>=20
> I don't totally understand why we're writing to *ns.  Do we access *ns ag=
ain
> or not?  Either way, this doesn't seem right.  In other words, why don't =
we
> do this:
>=20
> 		__le64 *period =3D dpaa2_get_ts(vaddr, false);
> 		u64 ns;
>=20
> 		ns =3D DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS *
> le64_to_cpup(period);
> 		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
> 		shhwtstamps->hwtstamp =3D ns_to_ktime(ns);
>=20
> Then if we need to save a munged *ns then we can do this at the end:
>=20
> 		/* we need this because blah blah blah */
> 		*period =3D (__le64)ns;
>=20

[Y.b. Lu] You're right. I will modify the code according to your suggestion=
.

>=20
> > +		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
> > +		shhwtstamps->hwtstamp =3D ns_to_ktime(*ns);
> > +	}
> > +
> >  	/* Check if we need to validate the L4 csum */
> >  	if (likely(dpaa2_fd_get_frc(fd) & DPAA2_FD_FRC_FASV)) {
> >  		status =3D le32_to_cpu(fas->status);
>=20
> [ snip ]
>=20
> > @@ -520,6 +561,19 @@ static void free_tx_fd(const struct dpaa2_eth_priv
> *priv,
> >  		return;
> >  	}
> >
> > +	/* Get the timestamp value */
> > +	if (priv->ts_tx_en && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
> > +		struct skb_shared_hwtstamps shhwtstamps;
> > +		u64 *ns;
> > +
> > +		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
> > +
> > +		ns =3D dpaa2_get_ts(skbh, true);
> > +		*ns =3D DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS * le64_to_cpup(ns);
> > +		shhwtstamps.hwtstamp =3D ns_to_ktime(*ns);
> > +		skb_tstamp_tx(skb, &shhwtstamps);
>=20
> Sparse issues here also.

[Y.b. Lu] Will modify the code according to your suggestion.

>=20
> > +	}
> > +
> >  	/* Free SGT buffer allocated on tx */
> >  	if (fd_format !=3D dpaa2_fd_single)
> >  		skb_free_frag(skbh);
> > @@ -552,6 +606,10 @@ static netdev_tx_t dpaa2_eth_tx(struct sk_buff
> *skb, struct net_device *net_dev)
> >  			goto err_alloc_headroom;
> >  		}
> >  		percpu_extras->tx_reallocs++;
> > +
> > +		if (skb->sk)
> > +			skb_set_owner_w(ns, skb->sk);
>=20
> Is this really related?  (I have not looked at this code).

[Y.b. Lu] Yes. The skb_tstamp_tx() function will check that.

>=20
> > +
> >  		dev_kfree_skb(skb);
> >  		skb =3D ns;
> >  	}
>=20
> [ snip ]
>=20
> > @@ -319,6 +351,9 @@ struct dpaa2_eth_priv {
> >  	u16 bpid;
> >  	struct iommu_domain *iommu_domain;
> >
> > +	bool ts_tx_en; /* Tx timestamping enabled */
> > +	bool ts_rx_en; /* Rx timestamping enabled */
>=20
> These variable names are not great.  I wouldn't have understood "ts_"
> without the comment.  "tx_" is good.  "en" is confusing until you read th=
e
> comment.  But really it should just be left out because "enable" is assum=
ed,
> generally.  Last week I asked someone to rewrite a patch that had a _disa=
ble
> variable because negative variables lead to double negatives which screw =
with
> my tiny head.
>=20
> 	if (blah_disable !=3D 0) {
>=20
> OH MY BLASTED WORD MY BRIAN ESPLODED!!!1!
>=20
> So let's just name these "tx_timestamps" or something.

[Y.b. Lu] Ok. Let me use tx_tstamp/rx_tstamp instead. The tstamp is common =
used in driver.

>=20
>=20
> > +
> >  	u16 tx_qdid;
> >  	u16 rx_buf_align;
> >  	struct fsl_mc_io *mc_io;
>=20
> regards,
> dan carpenter
