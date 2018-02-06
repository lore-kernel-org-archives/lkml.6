Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeBFAYh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:24:37 -0500
Received: from us-smtp-delivery-194.mimecast.com ([216.205.24.194]:40008 "EHLO
        us-smtp-delivery-194.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752207AbeBFAY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:24:29 -0500
X-MC-Unique: LrKFt2q0MSmsO3njH1UcXg-1
From: Trond Myklebust <trondmy@primarydata.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hacking@nachtgeist.net" <hacking@nachtgeist.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: It's back! (Re: [REGRESSION] NFS is creating a hidden port (left
 over from xs_bind() ))
Thread-Topic: It's back! (Re: [REGRESSION] NFS is creating a hidden port (left
 over from xs_bind() ))
Thread-Index: AQHTnG9SUuso/Q9QSkOQBHkQGCS1ZaOWiMMA
Date: Tue, 6 Feb 2018 00:24:23 +0000
Message-ID: <1517876654.79669.5.camel@primarydata.com>
References: <57220e1f-f81e-b30b-a4ea-39ad74c7c0d6@nachtgeist.net>
In-Reply-To: <57220e1f-f81e-b30b-a4ea-39ad74c7c0d6@nachtgeist.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@primarydata.com;
x-originating-ip: [50.36.85.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1308;20:86ZWl5H1aTWh+QXw99+oHW6WeZsD3R2E85GNEahwQuFTPINgrHzwW13fKbv2d0TUh7MvW7c1jB2MnA4tsGhvfFAjy5olfhSVWQTZwXDXErKAyJMhbbDkwiceyXIGAT456b/SIK7iu03EUJ4E+Hn43eohTHaCiTTJUqDScqLij4U=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: e5f962d0-57ea-4e3c-5b97-08d56cf7f900
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:DM5PR11MB1308;
x-ms-traffictypediagnostic: DM5PR11MB1308:
x-microsoft-antispam-prvs: <DM5PR11MB13082780EB9C30B013746F47BEFD0@DM5PR11MB1308.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(3002001)(10201501046)(6041288)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DM5PR11MB1308;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1308;
x-forefront-prvs: 0575F81B58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39380400002)(39830400003)(189003)(199004)(377424004)(6512007)(305945005)(4326008)(26005)(7736002)(186003)(66066001)(53936002)(6436002)(316002)(77096007)(3846002)(99936001)(6486002)(6116002)(2501003)(68736007)(3660700001)(3280700002)(6246003)(5660300001)(102836004)(6306002)(229853002)(2950100002)(105586002)(106356001)(86362001)(81156014)(81166006)(8676002)(97736004)(575784001)(478600001)(103116003)(2900100001)(6506007)(59450400001)(76176011)(2906002)(8936002)(99286004)(14454004)(54906003)(110136005)(25786009)(53546011)(36756003)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB1308;H:DM5PR11MB0075.namprd11.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: lSoSYTUyQ+yt8HyyDEXASu1t5CuVyOj9iPpfWzxyBAlksuOm11G+an5wXi1uT9ckZrObfUg3I7/pV5YhukBzJw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="=-Dsa4YuRoxRyzJpZuOjC+"
MIME-Version: 1.0
X-OriginatorOrg: primarydata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f962d0-57ea-4e3c-5b97-08d56cf7f900
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2018 00:24:23.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03193ed6-8726-4bb3-a832-18ab0d28adb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1308
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-Dsa4YuRoxRyzJpZuOjC+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-02-02 at 22:31 +0100, Daniel Reichelt wrote:
> Hi Trond, Steven,
>=20
> eversince I switched from Debian Jessie to Stretch last summer, I've
> been seeing the very same hidden ports on an NFS server as described
> in
> [1], which is a follow-up to [2].
>=20
> Your patch ([3], [4]) solved the issue back then. Later on, you
> changed
> that fix again in [5], which lead to the situation we're seeing
> today.
>=20
> Reverting 0b0ab51 fixes the issue for me.
>=20
> Let me know if you need more info.
>=20
>=20
>=20
> Thanks
> Daniel
>=20
>=20
> [1] https://lkml.org/lkml/2016/6/30/341
> [2] https://lkml.org/lkml/2015/6/11/803
> [3] https://lkml.org/lkml/2015/6/19/759
> [4] 4876cc779ff525b9c2376d8076edf47815e71f2c
> [5] 4b0ab51db32eba0f48b7618254742f143364a28d

Does the following fix the issue?

8<-----------------------------------------------
=46rom 9b30889c548a4d45bfe6226e58de32504c1d682f Mon Sep 17 00:00:00 2001
From: Trond Myklebust <trond.myklebust@primarydata.com>
Date: Mon, 5 Feb 2018 10:20:06 -0500
Subject: [PATCH] SUNRPC: Ensure we always close the socket after a connecti=
on
 shuts down

Ensure that we release the TCP socket once it is in the TCP_CLOSE or
TCP_TIME_WAIT state (and only then) so that we don't confuse rkhunter
and its ilk.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
---
 net/sunrpc/xprtsock.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 18803021f242..5d0108172ed3 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -807,13 +807,6 @@ static void xs_sock_reset_connection_flags(struct rpc_=
xprt *xprt)
 	smp_mb__after_atomic();
 }
=20
-static void xs_sock_mark_closed(struct rpc_xprt *xprt)
-{
-	xs_sock_reset_connection_flags(xprt);
-	/* Mark transport as closed and wake up all pending tasks */
-	xprt_disconnect_done(xprt);
-}
-
 /**
  * xs_error_report - callback to handle TCP socket state errors
  * @sk: socket
@@ -833,9 +826,6 @@ static void xs_error_report(struct sock *sk)
 	err =3D -sk->sk_err;
 	if (err =3D=3D 0)
 		goto out;
-	/* Is this a reset event? */
-	if (sk->sk_state =3D=3D TCP_CLOSE)
-		xs_sock_mark_closed(xprt);
 	dprintk("RPC:       xs_error_report client %p, error=3D%d...\n",
 			xprt, -err);
 	trace_rpc_socket_error(xprt, sk->sk_socket, err);
@@ -1655,9 +1645,11 @@ static void xs_tcp_state_change(struct sock *sk)
 		if (test_and_clear_bit(XPRT_SOCK_CONNECTING,
 					&transport->sock_state))
 			xprt_clear_connecting(xprt);
+		clear_bit(XPRT_CLOSING, &xprt->state);
 		if (sk->sk_err)
 			xprt_wake_pending_tasks(xprt, -sk->sk_err);
-		xs_sock_mark_closed(xprt);
+		/* Trigger the socket release */
+		xs_tcp_force_close(xprt);
 	}
  out:
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -2265,14 +2257,19 @@ static void xs_tcp_shutdown(struct rpc_xprt *xprt)
 {
 	struct sock_xprt *transport =3D container_of(xprt, struct sock_xprt, xprt=
);
 	struct socket *sock =3D transport->sock;
+	int skst =3D transport->inet ? transport->inet->sk_state : TCP_CLOSE;
=20
 	if (sock =3D=3D NULL)
 		return;
-	if (xprt_connected(xprt)) {
+	switch (skst) {
+	default:
 		kernel_sock_shutdown(sock, SHUT_RDWR);
 		trace_rpc_socket_shutdown(xprt, sock);
-	} else
+		break;
+	case TCP_CLOSE:
+	case TCP_TIME_WAIT:
 		xs_reset_transport(transport);
+	}
 }
=20
 static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
--=20
2.14.3

--=20
Trond Myklebust
Linux NFS client maintainer, PrimaryData
trond.myklebust@primarydata.com

--=-Dsa4YuRoxRyzJpZuOjC+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEESQctxSBg8JpV8KqEZwvnipYKAPIFAlp49a4ACgkQZwvnipYK
APL3jQ/+I3rLPwdub2QDL+2dGrkD2RjhdskiMn3kpYdOxbvTOlZ3DKKsBAB8JMLy
+xuaXN7WvDczN4XRVM9+x35FRffzpqjpKbfShfHs6BEQXNYTqIh1llZOUYAucKg3
0TH2hdgx+5SIb7k5Qs2TrrAgbsKShYnZe4AOy8yvNIr8qDeL1QvytFdop0JuQe9c
1b0rsNlP9dllrsVti1UVxJRm7z2mAZQqWOm0bSWiBkcUZyHrMTKKbSAviNauivb6
foJcpu9dA8j+o5utqqOc0g2aVXH/R08GbrS7iMTg5b5rOnaVYqDYwgW2MIURcROh
B+VLpY2yCkpaT8j17CZhOB6vfqCCLynLeFfwfj67YGnsFBqBbbpbHpYHLPgDlh9T
c+VjCNTRL7ZcHxnHBWEujSRaZ+b0efmLBipPx+MSzWQucbqv7b2auqFz2NccTiHx
QCWinsTjDhd75bduoDtX4HFqpG/tv1WG6TdCFpubPWBb2q6uJasraiBGSUd6ztp/
NoNQ3LaYI7BWXggO9oGgkFJz5hJvu5y3dowWrNL5XnVR54FTRfk4TNpXnzVa5MFs
s5mFV4cBQ9daJ9Z+yy3lHW89jtQZ2M2EkFNSKWBnG3TmY5T/dRk7OwY6eZjWOU4x
GKGRnGtxlxMKI/7qwUwPwysCch4+W1+yO4WptXtU6UicPdG21eY=
=kr3V
-----END PGP SIGNATURE-----

--=-Dsa4YuRoxRyzJpZuOjC+--
