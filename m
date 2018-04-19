Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeDSBg5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:36:57 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41653 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeDSBgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:36:54 -0400
X-Google-Smtp-Source: AIpwx4/EwqtOWEL5fmhoXlqiGNtsuAwC3+aRQrFrjdnhfxQWmWJmEbdgeVDbgnNuVWUuIDzj7iJFT/vbjhx0YC0yXEE=
MIME-Version: 1.0
Reply-To: chrisgregsson@gmail.com
In-Reply-To: <CAD4OcZhnvfxh-WaCHB-ixG44WFhp7vkEq9gXRYTLfYgh1bu1Ew@mail.gmail.com>
References: <CAD4OcZhrV_QPBr3s6A4dayRuMZ5cbL36jFVEmmGfhB_NEqNmDg@mail.gmail.com>
 <CAD4OcZg8rHm4OTnfMW=b6SvSHccZdDvLkcCGcx6umOgpiH5-Ug@mail.gmail.com>
 <CAD4OcZgv=SRoPvd0dfsmOr=qp+R298A+SoXp1hHx+7hyvUG3mw@mail.gmail.com>
 <CAD4OcZgKEi8uB_9WCBOBkaBpsOmoHeSmLPnQXO+HCGOr8k4Zbg@mail.gmail.com>
 <CAD4OcZgHD2R5r9iGoGgcToEKkN1Sim5OGa2xR1XXYbq4u0=hDg@mail.gmail.com>
 <CAD4OcZj_ayM5xh6zd1Z6aQ9Ot73z5RhdvCQFQFiskdCh5tDRfQ@mail.gmail.com>
 <CAD4OcZjievmkuj_QY_WBdFt5o7T++MkRd8-P5Ej_Rz72dJ-shQ@mail.gmail.com>
 <CAD4OcZh6sWRxcSb4n44_0_knukTS0V8f9pxpkmwkuRLgSGHuyA@mail.gmail.com>
 <CAD4OcZjWzD0AHuf7LGksBaNPZCmv1q-83_3zMEB+5-45kB2d-Q@mail.gmail.com>
 <CAD4OcZi8N2C0T_irCakJhZ9iDt_=c94bjVSGhrn0VQVh0zkQXg@mail.gmail.com>
 <CAD4OcZi0a8ddm8rBZ4okKCDaxqT0rocHjb_nkuOY=WfiHtP2Tg@mail.gmail.com>
 <CAD4OcZhphMk77YttXgFLpS5YvaFETsW4QoLgBErmBS1VW6pKUg@mail.gmail.com>
 <CAD4OcZiR2eUQt3gcbg3kNrdNnaFQXF5_JW3Wg_ts_kOPoSAO-A@mail.gmail.com>
 <CAD4OcZitJpUDdJJvZ9JjUb5gW1BSRRRX6v78kK8fm01YAjqavw@mail.gmail.com>
 <CAD4OcZiV7iyXCFr1A9hFLs1f6D49-HJtDizUysxHBtAYAfQMCA@mail.gmail.com>
 <CAD4OcZjQPQe42Obx0ZaZ6tphv95nCniw7rh9nFjK6PX4FrmevQ@mail.gmail.com>
 <CAD4OcZhYixzHmFtHu=U3MEchBYgSjuT8iiADd2Zn5h45X4VsUg@mail.gmail.com>
 <CAD4OcZg-fqS7r_FxOMfyvqw7Oz1tT-cMxhmmQ5ZOFnymw7EojQ@mail.gmail.com>
 <CAD4OcZggRJHYrKxOBnZ2V3YPXVgEd=8BszxoVm42DxEg+H4d3Q@mail.gmail.com>
 <CAD4OcZiUNeQ2iruuR+Q0GfwfE6-Z8-PZe15MFfE0x-E6Wy=F=w@mail.gmail.com>
 <CAD4OcZicWz5ZHL8oeKR6Rzc-0dZkAG6DkwChm6gi+GXEFHAaCQ@mail.gmail.com>
 <CAD4OcZhPRCejRGe_9_6aOFWbdK0oKf6h0Xd+4xyzzF3xCJh_bw@mail.gmail.com>
 <CAD4OcZh+GgOos6oiBC3O-seT4RVNFkqb=YRduvcFMRmrzTQd4w@mail.gmail.com>
 <CAD4OcZizvLn9Hn4ZZQzC=03_c87D7fxsFqCZi7aGrk0z7EyPdA@mail.gmail.com>
 <CAD4OcZhyvNwW5JSU5ixMQoisVy_FNALKH+9nZqHHV=iaPgfDyQ@mail.gmail.com>
 <CAD4OcZhzZvstDog69FK=et0WoYm6r6EF0y13Nh=DMP0pacQXRg@mail.gmail.com>
 <CAD4OcZg0UsYO48njs2TJysy-CorjKPcPuXWOSKyrVHct30Zs=w@mail.gmail.com>
 <CAD4OcZhHss5Pp79kEGsXg9Yr6bUf2p70EO1peyN9=9R=GGiV8A@mail.gmail.com>
 <CAD4OcZik9SXRVL__yeOAM4djkk2P-3E8-_kOOuqokFCSjYuOBw@mail.gmail.com>
 <CAD4OcZhuBMeNPWLhLMCYO-2orheYo-Xa90nU9V0wMxzwfkmvrw@mail.gmail.com>
 <CAD4OcZhmDPWjzciogeM5qFkoCPeqMjp5MVo6mWjydnicr2Q7HQ@mail.gmail.com>
 <CAD4OcZhzexEc_a8z78m-c7vTV3Pkfo=f7AHyJtXDvWN=+wvBfg@mail.gmail.com>
 <CAD4OcZjFRk+BmPyasz7a3_Z+KeQds7ykB+zuxVhJ20uR-_x3KA@mail.gmail.com>
 <CAD4OcZiVQO7xk9Hbs8vQ=4f8CK2QFF+GqmGSZJePAr7cQwwzsw@mail.gmail.com>
 <CAD4OcZg5FmXtTWprw_LfzS1zsiwJJv+1dQnB_koBo2A7jcMAcg@mail.gmail.com>
 <CAD4OcZg+oEYk+Kqm5SzNP4UekwRL_AnWPZKaYotuMEO1ddWNNQ@mail.gmail.com>
 <CAD4OcZgXcYE3QHqx7v5Mtb_6x8Des_KFRRtSeoU1C+UMF3R5TQ@mail.gmail.com>
 <CAD4OcZgVui1QsPwSjWyN3+9s7gVmoG8A7rbYADozLYuWK6KmaQ@mail.gmail.com>
 <CAD4OcZitGNnB83cTzK0BLXh3bkZCrOecji-F5dprVPsBbOdLOQ@mail.gmail.com>
 <CAD4OcZhx=pNNjhvDkURQKm3+QWW12XqT=JzZ3TTHMfbmWpn_pQ@mail.gmail.com>
 <CAD4OcZgLBRuHz0XFwj-8Ys5=o-zLoCiW37zqLFwQyyPiEtzgSQ@mail.gmail.com>
 <CAD4OcZhWHFTZxP9ytAS4PiebF=sdvUiEN02LGpP2mtciuVUGyw@mail.gmail.com>
 <CAD4OcZjTQdJz2-QE89LjBmqRA4QoxGrXXbAfLU7oHYcXK2L=9Q@mail.gmail.com>
 <CAD4OcZiu-5ab7Ui09mxRwPx4ngCa1ZvWHVf7=pf4NK-cw3v7MA@mail.gmail.com>
 <CAD4OcZjP2TZ=k26h5OGda23+vcfEO-oWJr3MxMU3nyfucf3LrQ@mail.gmail.com>
 <CAD4OcZgbjkNemSEPpHKMWstU94ZAKFOzff5vQv1BMJavH1YXjw@mail.gmail.com>
 <CAD4OcZhiM_B086gjT8kFqLa6AJtJoknDL9SicC9RMDto7qSZLQ@mail.gmail.com>
 <CAD4OcZisEBVzJiV7qCugsN0t-TPV=qQARKSd=qAuWCjaNz2sng@mail.gmail.com>
 <CAD4OcZg=S1LdFsT694ZcLZNgq-npgeDC_fGPJcZC_qLntu2FdQ@mail.gmail.com>
 <CAD4OcZgyXNsBvCMea7dczXtZduJ+ZrCe+S0xjdAJRF9DkwCqAg@mail.gmail.com>
 <CAD4OcZgXXLwW0NyxTAaKXVYcVsfF54oXkh_uNb2Us1+rx8TYAw@mail.gmail.com>
 <CAD4OcZioH2hX=USoMJv6oYfDGPu0gGxD7xi+Wo-bz8FX_-oktw@mail.gmail.com>
 <CAD4OcZj=6Lba2_XNmAr9Dkn+i6yJTJ-4Gc1d4yHGQnK5ZWxLxA@mail.gmail.com>
 <CAD4OcZiDDukkp2zX+N6XLd9xkphN1KPeYnu2xNMaBxcs0iHwig@mail.gmail.com>
 <CAD4OcZh55fK4kQ5xf-D2rQuUpDCfyrmW_vjE4uzuS5qTf_9a3Q@mail.gmail.com>
 <CAD4OcZgqqutbXXpS3a1BY1qhDorCJQ5tDTAoFDi7by3NCuXh=Q@mail.gmail.com>
 <CAD4OcZhZv_PHL=f-SUBgYmKNSz_OOMhuhEFuc714M70L_Sw2cw@mail.gmail.com>
 <CAD4OcZhpQAw9wdJk8V_QcL0U_JXSE6OXxJmp7o2Jhk1afaR0_Q@mail.gmail.com>
 <CAD4OcZhxi3cbjcN=og7hBGd-A0Bwno+uF+YK94siuOTkZ9rvYw@mail.gmail.com>
 <CAD4OcZiAFUd63Fjt0LggY=_1D7VDv3xRxjK8EdgKcS+XJA_9wQ@mail.gmail.com>
 <CAD4OcZjV6Q9WnFdaf=R+XmDQs-YcgUuku4Rc75r=yiJ09AMh3g@mail.gmail.com>
 <CAD4OcZgPdOgP-OHu8vOmgtr3mW3wqB94MDgf0LQJ8x7LoHMSWQ@mail.gmail.com>
 <CAD4OcZjvmzk9ZTGVu-kc=Cgbrh1EA9Ey9atT8bCUV-54d5VeRQ@mail.gmail.com>
 <CAD4OcZhpBRcx=gyL_mbkyKjEy0FFmh-jcfTd=THU4CTepVnU+g@mail.gmail.com>
 <CAD4OcZjiYzPfyP=ON7EmuQQe7+Bs4867fes-u5e-17bSBQp85g@mail.gmail.com>
 <CAD4OcZj3BpKNpp+OxvKZE9YN30XU36JeGKVgD-gHA4ad9T5UeQ@mail.gmail.com>
 <CAD4OcZh2vgtfSwghXBR0szqcD=VUj_S+aML+CxNX4FhnReSvQg@mail.gmail.com>
 <CAD4OcZg--WPBqmznXDCq24-DNayJF76dwnxmisRCD7spmCRD4A@mail.gmail.com>
 <CAD4OcZi0+0tC+-9ZKs0EHSmCOFjjWaPeu9e13Wzi3rBUdU5Vpg@mail.gmail.com>
 <CAD4OcZj1sVm+gy+yJUqmP5KwCjgU1WupeQ4Z+8KCVnqLFDRjMg@mail.gmail.com>
 <CAD4OcZiLOgqNZXRzcr1jZ7Q9RyFhwNWrbREewohsGm+N3aRmjw@mail.gmail.com>
 <CAD4OcZhLNiiJ2d0=joULW04_a48nFoD0+n-SgGBUiBEuFj0CSQ@mail.gmail.com>
 <CAD4OcZipDqHpGLRUEzZzA9oXtejaaZ29reNgNCLKw5pPdFG3CA@mail.gmail.com>
 <CAD4OcZjjZDT4AJ9KNYAqjp6gNNdKF-8ejVXrCEU21Q_J0urScg@mail.gmail.com>
 <CAD4OcZimg7cE9ors7OFUw5rkZ5bg8Abne9oV67Jfcz+pSbG+BQ@mail.gmail.com>
 <CAD4OcZjvjBjM3L-NmKrhsNpMqYcb+Lv2SnzuxcyuzrYNy4UUNw@mail.gmail.com>
 <CAD4OcZjCMZ_YTbXjD27p_fvMLf43GZdUAA0DU4Xxt8SNLiWkRQ@mail.gmail.com>
 <CAD4OcZiHaFdPLPctg1p126taD8HPG+pB7QzkPEk8Ftzb8R8uDw@mail.gmail.com>
 <CAD4OcZi7Tm4yYtSdaGR=b9M-LAqzjcrT8cKL2CxcG9TnNRZ0kg@mail.gmail.com>
 <CAD4OcZiV9EdMbWhgmD9epkT_tXRDXuO6JdYj=mKviSj5yyun0w@mail.gmail.com>
 <CAD4OcZg1fTzu3BFsQqOrd8Qw7pdDA+VN5-8fiaSZSyP7YTK0kQ@mail.gmail.com>
 <CAD4OcZhFPMNXH5=o2+U0D7Ka7fSJfYvOfLOAJ78Cekr-c3shBA@mail.gmail.com>
 <CAD4OcZhgMNP39Wyp+x7YkgBLdLvdHWACLmhFH=xqbdoOcDJBgA@mail.gmail.com>
 <CAD4OcZgF8zj2ZUad1i9Quj28BHdMTMZ5qj8Up-szoVW4NCvoEw@mail.gmail.com>
 <CAD4OcZjWt5fOrHu1+GbrbYrkhcmDAqKKRK7d3+XB3MDwwA42+Q@mail.gmail.com>
 <CAD4OcZjgFp=5vGtU42SxWUpmX2pf-qfGCV6Jj3SG9sHg_dBxnA@mail.gmail.com> <CAD4OcZhnvfxh-WaCHB-ixG44WFhp7vkEq9gXRYTLfYgh1bu1Ew@mail.gmail.com>
From: Christopher Gregson <wmofficemailss9@gmail.com>
Date: Wed, 18 Apr 2018 18:36:52 -0700
Message-ID: <CAD4OcZjQYR_PJjxPkGAdg7fherHU9=41aNOYa=ZMS2UUZnwXnA@mail.gmail.com>
Subject: INVESTMENT OPPORTUNITY
To: undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I write to you based on a request by an investor for
funding/investment in your project.

My name is Christopher Gregson, a financial consultant with Williams
Group UK Properties Limited.

My reason for contacting you is that my client who is a politician,
has an urgent need to invest a considerable amount of funds into
lucrative opportunities with you. My client's request is for a
competent individual or company such as you, who will be willing
to put this money to good use for a period of 10 years for a start.

Should this be of interest to you, please do not hesitate to e-mail me
back for further information.

I take this opportunity to thank you for taking your time to read the
contents of this email.

Kind regards,
Christopher Gregson
