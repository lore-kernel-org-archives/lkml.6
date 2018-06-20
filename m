Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D11FC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3EC2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=starvleads.com header.i=@starvleads.com header.b="ZMHZtQYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3EC2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=starvleads.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbeFTW0v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:26:51 -0400
Received: from p3nlsmtpcp01-02.prod.phx3.secureserver.net ([184.168.200.140]:54822
        "EHLO p3nlsmtpcp01-02.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933472AbeFTW0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:26:50 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2018 18:26:50 EDT
Received: from p3plcpnl0749.prod.phx3.secureserver.net ([50.62.177.7])
        by : HOSTING RELAY : with SMTP
        id VlQhfIt9JWZiZVlQhfb1WL; Wed, 20 Jun 2018 15:18:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=starvleads.com; s=default; h=Content-Type:MIME-Version:Message-ID:Date:
        Subject:In-Reply-To:References:To:From:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yr61D6EvBeUy0klyfT3XV5RyRgsqvqK65jtvjo6hquE=; b=ZMHZtQYE3ufVhAWwyL2BwrP1a
        5x9ySQ/BbKe9Cdj2GuhCAW17ULsaGurBV4+a+qKTAj4sqURWQZj0LrtscWr7ayPWPIvypo/z3y1fD
        iZPBb9r2d6Ozs1sXvg/yhl9SaLMSATN3gBj/Jy8yhkDo6e8lfw10No/CZPyxWz4xO95Iv3BPXvsl0
        b5gEqgyUe4rpCuHXKceq2op3kvnL8lJ9Lxr6IGK9HvVjWq4RewgvJHou3iNakb4uuNZMn3eB0/Idr
        9qx5NOsUg2Qf5Ay2GjEtpA1kMdT9pvM+vRQp/RiTC/4yAq2yD3rsU0DV1UFO6LV3C9vygJeqMsrCi
        tuqDedkjQ==;
Received: from [122.178.193.197] (port=53696 helo=userPC)
        by p3plcpnl0749.prod.phx3.secureserver.net with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.89_1)
        (envelope-from <nicole.suter@starvleads.com>)
        id 1fVlQh-00010T-4m
        for linux-kernel@vger.kernel.org; Wed, 20 Jun 2018 15:18:19 -0700
From:   "Nicole Suter" <nicole.suter@starvleads.com>
To:     <linux-kernel@vger.kernel.org>
References: 
In-Reply-To: 
Subject: Flash Memory Summit
Date:   Wed, 20 Jun 2018 18:17:05 -0400
Message-ID: <040401d408e4$93ebd920$bbc38b60$@starvleads.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0405_01D408C3.0CDB4A90"
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdQI4cJfwH/I6yXFQRy172AyuV6S7Q==
Content-Language: en-us
X-MS-TNEF-Correlator: 000000003DBA966BFBBBFD4EA014096E4E9A4D38C4312100
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p3plcpnl0749.prod.phx3.secureserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - starvleads.com
X-Get-Message-Sender-Via: p3plcpnl0749.prod.phx3.secureserver.net: authenticated_id: nicole.suter@starvleads.com
X-Authenticated-Sender: p3plcpnl0749.prod.phx3.secureserver.net: nicole.suter@starvleads.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfISicqKO6Fs+xWyK1dKbnoS8rcumb0wOamjtUoSiABMJfCO3x2zwGUTXzOryQ5CqT6JM96f3KZAFC9hBx4nAyEzxDc0Dup9eehsctaXhfRV1wZ3MVS4C
 0EYIpFuJ0VBK6Uq1GYaIT3hnAjhJjQubx4pYvub+eoVVd9MNJDdL7WF/z4GynFwIAqvW4LjDnWgvzYg0saJL3JusjrBamNlbLLYWdKTl4CbzYstEtRwvLBVs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_0405_01D408C3.0CDB4A90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

Would you be interested in the Attendee list of Flash Memory Summit?

 

Let me know your interest to send you the number of Attendees and cost.

 

Awaiting your reply.

            

Kind regards,

Nicole Suter  | Marketing Associate

 

If you do not wish to receive future emails from us, please reply as "Leave
out".

 


------=_NextPart_000_0405_01D408C3.0CDB4A90
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

eJ8+IgwWAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQgABQAEAAAAAAAAAAAAAQkABAACAAAAAAAAAAEDkAYAZBEAADAA
AAALAAIAAQAAAAMAJgAAAAAACwApAAAAAAALACsAAAAAAAMALgAAAAAAHgBNAAEAAAABAAAAAAAA
AB4AcAABAAAAFAAAAEZsYXNoIE1lbW9yeSBTdW1taXQAAgFxAAEAAAAWAAAAAdQI4cJfwH/I6yXF
QRy172AyuV6S7QAACwAXDAAAAAALAAEOAAAAAAIBCg4BAAAAGAAAAAAAAAA9upZr+7v9TqAUCW5O
mk04woAAAAMAFA4BAAAAHgAoDgEAAABBAAAAMDAwMDAwMjABbmljb2xlLnN1dGVyQHN0YXJ2bGVh
ZHMuY29tAW5pY29sZS5zdXRlckBzdGFydmxlYWRzLmNvbQAAAAAeACkOAQAAAEEAAAAwMDAwMDAy
MAFuaWNvbGUuc3V0ZXJAc3RhcnZsZWFkcy5jb20Bbmljb2xlLnN1dGVyQHN0YXJ2bGVhZHMuY29t
AAAAAAMA3j+fTgAAAwDxPwkEAAADAAJZAAAWAAMACVkCAAAAAwATgAggBgAAAAAAwAAAAAAAAEYA
AAAAEIUAAAABAAALABWACCAGAAAAAADAAAAAAAAARgAAAAADhQAAAAAAAAMAKYAIIAYAAAAAAMAA
AAAAAABGAAAAAAGFAAAAAAAAAwBOgAMgBgAAAAAAwAAAAAAAAEYAAAAAEIEAAAAAAAADAE+AAyAG
AAAAAADAAAAAAAAARgAAAAARgQAAAAAAAAsAUIADIAYAAAAAAMAAAAAAAABGAAAAACSBAAAAAAAA
HgBRgAMgBgAAAAAAwAAAAAAAAEYAAAAAJ4EAAAEAAAABAAAAAAAAAAsAUoADIAYAAAAAAMAAAAAA
AABGAAAAACaBAAAAAAAACwBTgAggBgAAAAAAwAAAAAAAAEYAAAAABoUAAAAAAAALAFSACCAGAAAA
AADAAAAAAAAARgAAAAAOhQAAAAAAAAMAVYAIIAYAAAAAAMAAAAAAAABGAAAAABiFAAAAAAAAAwBW
gAggBgAAAAAAwAAAAAAAAEYAAAAAQoUAAAAAAAgCAVeACCAGAAAAAADAAAAAAAAARgAAAAAghQAA
AQAAAGQBAAACAQQAAAAAAAAABVJlcGx5CElQTS5Ob3RlB01lc3NhZ2UCUkUFAAAAAAAAAAABAAAA
AAAAAAIAAABmAAAAAgAAAAEAAAAMUmVwbHkgdG8gQWxsCElQTS5Ob3RlB01lc3NhZ2UCUkUFAAAA
AAAAAAABAAAAAAAAAAIAAABnAAAAAwAAAAIAAAAHRm9yd2FyZAhJUE0uTm90ZQdNZXNzYWdlAkZX
BQAAAAAAAAAAAQAAAAAAAAACAAAAaAAAAAQAAAADAAAAD1JlcGx5IHRvIEZvbGRlcghJUE0uUG9z
dARQb3N0AAUAAAAAAAAAAAEAAAAAAAAAAgAAAGwAAAAIAAAABAEFUgBlAHAAbAB5AAJSAEUADFIA
ZQBwAGwAeQAgAHQAbwAgAEEAbABsAAJSAEUAB0YAbwByAHcAYQByAGQAAkYAVwAPUgBlAHAAbAB5
ACAAdABvACAARgBvAGwAZABlAHIAAAsAWIAIIAYAAAAAAMAAAAAAAABGAAAAAIKFAAABAAAAAwBZ
gAcOABEbtdZAryHKqF7asdAAAAAAFQAAAAAAAAAeAFqACCAGAAAAAADAAAAAAAAARgAAAADYhQAA
AQAAAAkAAABJUE0uTm90ZQAAAAALAB8OAQAAAAIB+A8BAAAAEAAAAD26lmv7u/1OoBQJbk6aTTgC
AfoPAQAAABAAAAA9upZr+7v9TqAUCW5Omk04AwD+DwUAAAACAQkQAQAAABELAAANCwAAICsAAExa
RnVapCOfAwAKAHJjcGcxMjWCMgNDaHRtbDEDMfhiaWQEAAMwAQMB9wqAJwKkA+MCAGNoCsBzZfh0
MCAHEwKAEIMAUARWvwhVB7ISVQ5RAwERVzIGAPsGwxJVMwRGEVkTaxJjCO9tCfc7GU8OMDUSUgxg
Y2cAUAsJAWQzNhHgC6U0ciAQgipcDrIBkA4QOWQgPA6yIHgO0ACAOkh2PSIIcG46BPBoYmUAwHMt
bQ3gA2Bzam8BgC0FoG0f0A7QIl0fdW8f/yEJITBmDeBleyQlIeZ3In8jjyVwBbBkjSHmeCWfJq86
ZXgkcA0h120okA6wdHA6L6ovKPUuINcuIXEvJDRiLwHQMDQvDiAtgG0LIccrp3cvwC53My4BBbBn
L1RSL1JFhEMtDrI0MCI+EmONHmczHgAfIGVhZDFdNDE2DvA8B4ABkCBuMmEHgD1HCfAEkGF0rwWx
BaACMAnwdCiQTSDmpCBXJ9EgMR4AKCRQNx6wBJAJgCAHgA9QdW0OKTFOHfAz0XN0eWxGZTgfM9Eh
LS0Koy/IKiBGAiEgRAEQC4CYaXRpAiAEICovCqPSQAISLWYA0GUKpAGRDQMwez0lINBseTpDeQdA
aWIFEBpgPccKsG4hIRBlLTE6FXAxNd4gQRAVcEFSHgAzQYIaYC59PM893z7jIgZgZ2/gZSBVSSI/
r0C0DvBvQTIeAEcUFXAzQiY7YVNHOWI73wrBcC5NISBO4wWwAMBsLCA/UEo6D1A+dko4Q0oAwDBA
C4A6MHcLgEVpTWQtBuACQCGBLnkuEDAxBTBFaUKzAJB6PySARsBPkE/vREc/NSIsfCJzAHFQ8AZy
RVFCRGifHCNM5yEgUPA5Yi1wBRB3BbA8MD8QOU4KVfc/UG7aa0SwSDKRC4BnNrATUP8RgUVaTrU1
ACvwHfBRfU61/QUQZw6wTc9O2l0PTuI5gN8BgF6/Tt9RmwqwZ0CgP3AxMpBrLWEBgASQOmH8dm8P
QFAPURNbPlJtBtCfByFTolQ1Q1cYwzojHVDwNUY5MVSHDlBVP1ZP/1dfWG0VcFl/a8FaeGPgHrD9
ZEB1NQBgn1yfcA1htHEv919/YIpQuThmH0QpB21oSf9UpRZgaw9sH20vWG1B0G9P+VqIMTBbT3KP
YM9ef3ZP/4Z/Ya9iv2PPd49RT2b/aA+BaRw0RjgxQkRUh/40fK99v37PWF4eAID/gg//ly+EL4if
ml+HX5rfiX+Kj/+Ln4yvjb+Oz4/fkO+iHTliljo8MD9BY0ImYTpYco1K0HNAUUoySHlwBJD/WHKS
f5ONlGpphAoyRWk1cB54IVAFgzTwPFE6dW7vBIFYca7BqYZ2BAA8MAmA16pPWJA7kGwY4HcJgKt/
+6yPpj5wCHALUK7Pr9+w6fVKJVMKsGNZEUrYuodL1/+6hbPfk4xqQZ4Nna+ev6OPX6Lvo/9TH1Qs
SiNMBAB0zlAKwB7QNOBwaErWx83/S9XHy70vk4wyQMB/WtPAT8+Zv8C/m9+c6y410j/Bb3/Cf8OP
xJ/Fr1RKskNY1TH/lsLLT5ODNFJYv5R/k5/e//9YbkVapF+lb2kvajLWLLOg/9ATBuGh4dqvOPDb
39zvbs9/4P/gH+Evbnri/+gP2uwz/+oP6x+Af+8v7k/vX4Aq8S+/5A/lH6bP8W/yf9soNPQ///VP
lk/5X/h/+Y+V+vtf/G9//X/+j/+fAKenz6jfskNF90uAFMBIkzJ8nwZEvuCy4K+24BbAISA0UGwh
YnBAga8Jn9jP2dvlrXd0kGSzkJ+4AgEbybC3ISFhbnYUUP+x8dbwupFDOwNtGp8bokfm+0oyBQBw
SPF1cDpQG+8TqPcqwBUAG0AtNVA/AA9P1xPfmIVCRaCSNmNE0GO4slUb/9cDeLDT0Uax1ZDT78AR
J3N/NrAo/kfmS9IlP0OVoJI6rysaR+Y68DmvOTPgLzlfZTppWxfgIGex8AfiIKA5XT48eDCAPjsT
8DxvOnOW0LLgsKAf8508gHYh4TWhN6F0IrIxm6HQS4B4NECYcDI2NKCaLzKFLzJSOtBbZbCQPRfg
XS4vMN8x7zL1bGG8eW91gDPrMoc04nAz7PpkuKBhNTE1mTpLOYA2PzM3TDgyL2jd4Tc9NTAzMtAA
0GR5SuB7UGc9YEVOLVVTSuFYkD3/rpIz4ERjtvQ3MDejG0A4wPZcQ7KYcDP2sEXmQzA3Wzw5NjLQ
ygFpcDqwc3O+PSsaRck3cEcvN9M2BOCuPDywSQS6M3J7QGwRcDkvoj0nuAN1chuTOm6ZHgBlJ0ov
Sz9nOExhd7JCTaYjWTLXcxX7K1Bncm8lEFVJFzxPX1BkSFxpLDddTGEy8HA3PjX37IA+oli+OVnS
skJFyUXX/0MwReY+Ulx4N1BF6CBRXoj9R503WdJYvkxfTW9Of1YP/1CfUa9Sv1PPVN9lb2Z/WD9R
ZygmbmKyQDtF2Sf8YTBsr1lfWm9bf1yPXZ//Xq9xH2DPYd9i72P/ZQ9sn/9nL2g/aU9qX2tvfqsr
ECAQ5GQgOtEgYiUQ1PChYT5lyTCzsIaxt/BB8CBBO9VAQDFlJRCpMMkwIG+7OMB/f2KEmxxhfudG
SRFgaCBNZW3mYEOQU6R1bRZgdD9zHy+KCv91KW1Pbl9yT3NfdG91f3aP/3efjz95v3rPe998733/
l8//gB+BL4I/g0+EX54/j/9u3/9v76SvkV+Sb5N/lI+Vn5av/6kfmM+Z35rvm/+dD6Sfny+foD+h
T6Jfo2+2q0xlOwDp3ZAga7XAd4ZCIHCGxr+HkDlAFSBAQIZDh6JujID/hpAgcIjBh+Yz0BGghjAU
0P3JMC6lT6Zfqk+rX6xvrX//ro+vn7c/sb+yz7PftO+1///Kv7gfuS+6P7tPvF/RL8Lv/6bfp+/X
n8RPxV/Gb8d/yI//yZ/cD8u/zM/N387vz//Xjz/SH9Mv1D/VT9Zf6ZtBd78R8CuA9oG+s4cARZB5
wl//2T/dL94/30/gX+Fv4n/qH//kn+Wv5r/nz+jf+m/q/+wP/+0f7i/vPwDf2h/bLwevCL//Cc8K
3wvvDP8ODw8fEC8RP/8STxNfFG8VfxaPF58Yrxm//xrPG98c7x3/Hw8gHyEvIj//I08kVNgv8y/0
P/VP9l/3b//4f/mPJG/7r/y//c/+3//vfy/vAg8DHwQvBT8GTzZYS5fxMMHwhwBnL4Bkc1dv/yiv
Kb8qzyvfLO8t/y8PNq//MS8yPzNPNF81b0aPiY+Kn39NnzgPOR86Lzs/TG/wwE7+acIQUdCMYYbh
J5xCD46f/40fWQ9aH1EfUi9TP1RPVV9nXI8lbyZ/IHyL8EYgawu+APEyQUmwb2NpYf+IAD5PP19A
b1ffWO9Dn0Sv/0W/Yy9H30jvSf9LD0wfb+//XY9en1+vYL9hz3ZfaB9jj/9kn3zPaX9qj2ufbK9t
v27P/4E/cO9x/3MKfA+Iv3evVuEhc3A6I0E2kBI7bVdzQHuAeFItdEJmekBsP3oAkXKPr5C/kXJz
oHBo0mF5QDAweXAle/+NdHZJjQDAEmS/oHUwvhB3OGlzaL+C8cB1AGl23VcQZnSgvtBXEGVzkHpA
gcGwZnJvbSB1PiD6IPHgZXLwVxDxw8HAwbBBft8jODIyMIArOdozvVphmEHAIHSa75vy+jGcTDSN
OPIffm+CX4Nv/4R/hY+Gn4evjY+Jz4rfi+//jP+hn36vf7+Az6L/sBOnHz+oL6k/qk+ivZTArFEv
ZEeYMKW/t49nNThbQm90ZHmivjdbQa9SorB9Ab7wAAAAAwANNP0/pQ4DAA80/T+lDgIBFDQBAAAA
EAAAAE5JVEH5v7gBAKoAN9luAAACAX8AAQAAADEAAAAwMDAwMDAwMDNEQkE5NjZCRkJCQkZENEVB
MDE0MDk2RTRFOUE0RDM4QzQzMTIxMDAAAAAAAwAGEOZEGV4DAAcQ8AAAAAMAEBAAAAAAAwAREAEA
AAAeAAgQAQAAAGUAAABISSxXT1VMRFlPVUJFSU5URVJFU1RFRElOVEhFQVRURU5ERUVMSVNUT0ZG
TEFTSE1FTU9SWVNVTU1JVD9MRVRNRUtOT1dZT1VSSU5URVJFU1RUT1NFTkRZT1VUSEVOVU1CRVJP
AAAAAGfV

------=_NextPart_000_0405_01D408C3.0CDB4A90--

