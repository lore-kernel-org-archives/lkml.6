Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeBFT0h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:26:37 -0500
Received: from us-smtp-delivery-194.mimecast.com ([216.205.24.194]:36504 "EHLO
        us-smtp-delivery-194.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752724AbeBFT0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:26:35 -0500
X-MC-Unique: O-W0akPoNJGjdlMBkDIl6w-1
From: Trond Myklebust <trondmy@primarydata.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hacking@nachtgeist.net" <hacking@nachtgeist.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: It's back! (Re: [REGRESSION] NFS is creating a hidden port (left
 over from xs_bind() ))
Thread-Topic: It's back! (Re: [REGRESSION] NFS is creating a hidden port (left
 over from xs_bind() ))
Thread-Index: AQHTnG9SUuso/Q9QSkOQBHkQGCS1ZaOWiMMAgACVywCAAKlSgA==
Date: Tue, 6 Feb 2018 19:26:29 +0000
Message-ID: <1517945183.39096.4.camel@primarydata.com>
References: <57220e1f-f81e-b30b-a4ea-39ad74c7c0d6@nachtgeist.net>
         <1517876654.79669.5.camel@primarydata.com>
         <9518bb1f-ad0a-2c33-d3fc-78550be06a0c@nachtgeist.net>
In-Reply-To: <9518bb1f-ad0a-2c33-d3fc-78550be06a0c@nachtgeist.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@primarydata.com;
x-originating-ip: [50.36.85.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1532;7:9xCrcKGRF6qnk0VMw8hMW1lfcvPA1RCpRR+w3MPEVApiFiGs9mAoPx/s3gNqD7tlg/q5noVDCRflJKwweCfzomuZyHcQ0f693TWfI1zWlR9b7MAbLR9IK0ER70MflM/0n9RxPaoWqwRnGvfeur0XzZHmn1fnu/K2iydwlS1dcmT/yJtdgaYDQErB0UEcIH4+tTubFwq7DvsU8kF2N1G3L9gEhEgovqIvDKKrOt52dHZ5sPFMB/EyJpFDW7Dr+sAH;20:vZm+hY1pOtNKwecjqm3sesi/EMTuiN8TSfNrvYmKGtkEPisySB5EABzksoYBjSoHXWHjhliWRyUT0rfFBfRlQZnHSP70u+v+9yf8J0GWNGxXySxAGY6MXPxetaHe7q9SiZ/R6cqMxfJinWCsI8gMviX1Kx5VzvdJFhZahBkCIWA=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 2f8adc4a-2884-4381-f285-08d56d9785c5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:DM5PR11MB1532;
x-ms-traffictypediagnostic: DM5PR11MB1532:
x-microsoft-antispam-prvs: <DM5PR11MB15321213E9CB040F0A30D6BBBEFD0@DM5PR11MB1532.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(6041288)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DM5PR11MB1532;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1532;
x-forefront-prvs: 0575F81B58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39830400003)(346002)(376002)(396003)(189003)(199004)(377424004)(103116003)(186003)(14454004)(6116002)(68736007)(36756003)(478600001)(5660300001)(305945005)(229853002)(3846002)(99936001)(6512007)(76176011)(102836004)(106356001)(59450400001)(8936002)(97736004)(26005)(2950100002)(316002)(7736002)(81166006)(81156014)(54906003)(6436002)(53546011)(66066001)(2900100001)(6506007)(6486002)(77096007)(110136005)(4326008)(6246003)(3660700001)(53936002)(8676002)(25786009)(86362001)(3280700002)(2501003)(105586002)(2906002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB1532;H:DM5PR11MB0075.namprd11.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 53sVV89mux1bVO22f7qT6ZfqfAuBQkO3IYZbRflTQQe6SiXgfYKdWJ7GcqWhmPm9xHjNl6i+nMsGNTDee2YCCQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="=-t+YRnEZijbyrem38IAFf"
MIME-Version: 1.0
X-OriginatorOrg: primarydata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8adc4a-2884-4381-f285-08d56d9785c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2018 19:26:29.4156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03193ed6-8726-4bb3-a832-18ab0d28adb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1532
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-t+YRnEZijbyrem38IAFf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-02-06 at 10:20 +0100, Daniel Reichelt wrote:
> On 02/06/2018 01:24 AM, Trond Myklebust wrote:
> > Does the following fix the issue?
> >=20
> > 8<-----------------------------------------------
> > From 9b30889c548a4d45bfe6226e58de32504c1d682f Mon Sep 17 00:00:00
> > 2001
> > From: Trond Myklebust <trond.myklebust@primarydata.com>
> > Date: Mon, 5 Feb 2018 10:20:06 -0500
> > Subject: [PATCH] SUNRPC: Ensure we always close the socket after a
> > connection
> >  shuts down
> >=20
> > Ensure that we release the TCP socket once it is in the TCP_CLOSE
> > or
> > TCP_TIME_WAIT state (and only then) so that we don't confuse
> > rkhunter
> > and its ilk.
> >=20
> > Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
> > ---
> >  net/sunrpc/xprtsock.c | 23 ++++++++++-------------
> >  1 file changed, 10 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > index 18803021f242..5d0108172ed3 100644
> > --- a/net/sunrpc/xprtsock.c
> > +++ b/net/sunrpc/xprtsock.c
> > @@ -807,13 +807,6 @@ static void
> > xs_sock_reset_connection_flags(struct rpc_xprt *xprt)
> >  	smp_mb__after_atomic();
> >  }
> > =20
> > -static void xs_sock_mark_closed(struct rpc_xprt *xprt)
> > -{
> > -	xs_sock_reset_connection_flags(xprt);
> > -	/* Mark transport as closed and wake up all pending tasks
> > */
> > -	xprt_disconnect_done(xprt);
> > -}
> > -
> >  /**
> >   * xs_error_report - callback to handle TCP socket state errors
> >   * @sk: socket
> > @@ -833,9 +826,6 @@ static void xs_error_report(struct sock *sk)
> >  	err =3D -sk->sk_err;
> >  	if (err =3D=3D 0)
> >  		goto out;
> > -	/* Is this a reset event? */
> > -	if (sk->sk_state =3D=3D TCP_CLOSE)
> > -		xs_sock_mark_closed(xprt);
> >  	dprintk("RPC:       xs_error_report client %p,
> > error=3D%d...\n",
> >  			xprt, -err);
> >  	trace_rpc_socket_error(xprt, sk->sk_socket, err);
> > @@ -1655,9 +1645,11 @@ static void xs_tcp_state_change(struct sock
> > *sk)
> >  		if (test_and_clear_bit(XPRT_SOCK_CONNECTING,
> >  					&transport->sock_state))
> >  			xprt_clear_connecting(xprt);
> > +		clear_bit(XPRT_CLOSING, &xprt->state);
> >  		if (sk->sk_err)
> >  			xprt_wake_pending_tasks(xprt, -sk-
> > >sk_err);
> > -		xs_sock_mark_closed(xprt);
> > +		/* Trigger the socket release */
> > +		xs_tcp_force_close(xprt);
> >  	}
> >   out:
> >  	read_unlock_bh(&sk->sk_callback_lock);
> > @@ -2265,14 +2257,19 @@ static void xs_tcp_shutdown(struct rpc_xprt
> > *xprt)
> >  {
> >  	struct sock_xprt *transport =3D container_of(xprt, struct
> > sock_xprt, xprt);
> >  	struct socket *sock =3D transport->sock;
> > +	int skst =3D transport->inet ? transport->inet->sk_state :
> > TCP_CLOSE;
> > =20
> >  	if (sock =3D=3D NULL)
> >  		return;
> > -	if (xprt_connected(xprt)) {
> > +	switch (skst) {
> > +	default:
> >  		kernel_sock_shutdown(sock, SHUT_RDWR);
> >  		trace_rpc_socket_shutdown(xprt, sock);
> > -	} else
> > +		break;
> > +	case TCP_CLOSE:
> > +	case TCP_TIME_WAIT:
> >  		xs_reset_transport(transport);
> > +	}
> >  }
> > =20
> >  static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
> >=20
>=20
>=20
> Previously, I've seen hidden ports within 5-6 minutes after re-
> starting
> the nfsd and re-mounting nfs-exports on clients.
>=20
> With this patch applied, I don't see any hidden ports after 15mins. I
> guess it's a valid fix.

For the record, the intention of the patch is not to adjust or correct
any connection timeout values. Merely to ensure that once the
connection breakage is detected by the socket layer, so that is it no
longer usable by the RPC client, we release the socket.

--=20
Trond Myklebust
Linux NFS client maintainer, PrimaryData
trond.myklebust@primarydata.com

--=-t+YRnEZijbyrem38IAFf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEESQctxSBg8JpV8KqEZwvnipYKAPIFAlp6AV8ACgkQZwvnipYK
APK7uQ/9E318IX/ZMSHB5NbkbyVEx202GIiUmNTamO9Vi8aWGs1pSvurna5yfaNe
fkTuTpHoNHRY40HZzaNCluJB8VWRsjTZwJ3z9vj7TVfFlk+udXwD3CCNQkFc4fUo
M4U2uMGQ3Vz3OrA0nwT38h6WaHaiyePN8yvRtXgh4Yq0HQJKFmRRyqaukecSW4er
TOGpo38Qjn2ecVD6CCbCzxJdAnapmFqWglz9br0E65R2ZJvX3oFZGlIFlTwDLZJl
PraBIWncuECPRYXq3/4oLPcJxCdZ1Gp13+naiLfWW2D5/C72nx2vGZn9q0a1YWN7
+W1zaQ1RiSB/mQ7oM8jnZDntqcVo6Oeox1vg304fMYFRW/LgWeL4nHku4vR/Optg
Md6D9pdc6adaTRl52lZ8m4ganv2OwyIR7cMCs36ngn1xMIWbRqmpINyPOATaQeMg
sw3lD2mPQb7zHvagGy8WK4J624OZjasRI5QRtIx14LnlwsGHb3pvF5/S1wtk+T2L
A1L/GEuogz8zbK32oFvZUAUY/Zui0EomZhE+xpLVKMrK7BhN4KyAPcj8N6J8pwOm
WndE3Sb6Om1PecGWV66dWYjN5b3vOiDSHJvObtFA2jsYfMpoLJUXo3gRrwOafKDR
UkKBjXq5jsxJfWKtfKyya4XCFBGoyiDq4EGJPUgrKdq1ktKwNpU=
=i3tz
-----END PGP SIGNATURE-----

--=-t+YRnEZijbyrem38IAFf--
